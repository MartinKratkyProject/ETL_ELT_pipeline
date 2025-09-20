from airflow import DAG
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.operators.python import PythonOperator
from airflow.utils.dates import days_ago
from datetime import datetime, timedelta
from airflow.models.param import Param
from airflow.models import Variable
import pandas as pd
import json
import requests

warehouse_pg_conn_id = Variable.get("warehouse_pg_conn_id")

json_confs = [
    {"url": "https://data.cityofnewyork.us/resource/nc67-uf89.json", "table_name": "table_nyc_parking_fines", "schema_name": "raw_data", "if_exists": "append", "skip": False},
    {"url": "https://data.cityofnewyork.us/resource/8wbx-tsch.json", "table_name": "table_nyc_fire_vihecles", "schema_name": "raw_data", "if_exists": "append", "skip": False},
    {"url": "https://data.cityofnewyork.us/resource/vx8i-nprf.json", "table_name": "table_nyc_civil_services", "schema_name": "raw_data", "if_exists": "append", "skip": False},
]

csv_files = [
    {"path": "/opt/airflow/dags/data/csv/crocodile_dataset.csv", "table_name": "table_csv_crocodiles", "schema_name": "raw_data", "if_exists": "append", "skip": False},
]

xlsx_files = [
    {"path": "/opt/airflow/dags/data/xlsx/DD_DOB_Job_Application_Filings_2019-06-19.xlsx", "table_name": "table_xlsx_job_applications", "schema_name": "raw_data", "if_exists": "append", "skip": False},
]

default_params = {

}

default_args = {
    "owner": "airflow",
    "retries": 0,
    "retry_delay": timedelta(minutes=1),
}


def def_test(**context):
    print("test")


def convert_dict_columns_to_json(df: pd.DataFrame) -> pd.DataFrame:
    """
    Convert any column in the DataFrame that contains dicts into JSON strings.
    """
    for col in df.columns:
        if df[col].apply(lambda x: isinstance(x, dict)).any():
            df[col] = df[col].apply(lambda x: json.dumps(x) if isinstance(x, dict) else None)
    return df

def def_api_data(**context):
    for conf in json_confs:
        if conf["skip"]:
            print(f"Skipping {conf['table_name']}")
            continue
        print(f"Fetching {conf['table_name']}")
        url = conf["url"]
        table_name = conf["table_name"]
        schema_name = conf["schema_name"]
        if_exists = conf["if_exists"]

        resp = requests.get(url)
        resp.raise_for_status()
        data = resp.json()

        df = pd.DataFrame(data)

        df = convert_dict_columns_to_json(df)

        hook = PostgresHook(postgres_conn_id=warehouse_pg_conn_id)
        engine = hook.get_sqlalchemy_engine()

        hook.run(f"TRUNCATE TABLE {schema_name}.{table_name}")

        df.to_sql(
            name=table_name,
            schema=schema_name,
            con=engine,
            if_exists=if_exists,
            index=False
        )  

def def_fetch_csv(**context):
    for file in csv_files:
        if file["skip"]:
            print(f"Skipping {file['table_name']}")
            continue
        print(f"Fetching {file['table_name']}")
        path = file["path"]
        table_name = file["table_name"]
        schema_name = file["schema_name"]
        if_exists = file["if_exists"]

        df = pd.read_csv(path)

        df = convert_dict_columns_to_json(df)

        hook = PostgresHook(postgres_conn_id=warehouse_pg_conn_id)
        engine = hook.get_sqlalchemy_engine()

        df.to_sql(
            name=table_name,
            schema=schema_name,
            con=engine,
            if_exists=if_exists,
            index=False
        )

def def_fetch_xlsx(**context):
    for file in xlsx_files:
        if file["skip"]:
            print(f"Skipping {file['table_name']}")
            continue
        print(f"Fetching {file['table_name']}")
        path = file["path"]
        table_name = file["table_name"]
        schema_name = file["schema_name"]
        if_exists = file["if_exists"]

        df = pd.read_excel(path)

        df = convert_dict_columns_to_json(df)

        hook = PostgresHook(postgres_conn_id=warehouse_pg_conn_id)
        engine = hook.get_sqlalchemy_engine()

        df.to_sql(
            name=table_name,
            schema=schema_name,
            con=engine,
            if_exists=if_exists,
            index=False
        )


with DAG(
    dag_id="get_raw_data_dag",
    default_args=default_args,
    params=default_params,
    schedule_interval="0 4 * * *",  # Every Monday at 4 AM
    start_date=days_ago(1),
    catchup=False,
    tags=["etl", "elt", "postgres"],
) as dag:
    
    task_test = PythonOperator(
        task_id="task_test",
        python_callable=def_test,
    )
 
    task_fetch_api_data = PythonOperator(
        task_id="task_fetch_api_data",
        python_callable=def_api_data,
    )

    task_fetch_csv_data = PythonOperator(
        task_id="task_fetch_csv_data",
        python_callable=def_fetch_csv,
    )


    task_fetch_xlsx_data = PythonOperator(
        task_id="task_fetch_xlsx_data",
        python_callable=def_fetch_xlsx,
    )

    task_test >> [task_fetch_api_data, task_fetch_csv_data, task_fetch_xlsx_data]
