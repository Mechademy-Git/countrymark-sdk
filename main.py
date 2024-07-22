from collections import defaultdict
import requests
from datetime import datetime, timedelta
from sqlalchemy import text
import pandas as pd
import os
import json
import yaml
from contextlib import contextmanager
from sqlalchemy import create_engine
from sqlalchemy.orm import declarative_base, sessionmaker
from dotenv import load_dotenv


# ================== ENV VARIABLES ==================
load_dotenv()
CONFIG_FILE = "config.yaml"
POST_ENDPOINT_URL = os.environ.get(
    "POST_ENDPOINT_URL", "http://localhost:8000/api/v1/upload-json"
)
DATABASE_URL = os.environ.get("DATABASE_URL", "sqlite:///./db.sqlite3")
FETCH_QUERY_PATH = os.environ.get("FETCH_QUERY_PATH", "queries/fetch.sql")
BATCH_SIZE = int(os.environ.get("BATCH_SIZE", 30))
POST_API_KEY = os.environ.get("POST_API_KEY", "supersecretkey")
# ===================================================


# ================== DATABASE SETUP ==================
engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()


@contextmanager
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


# ===================================================


# ================== CONFIGURATION ==================
def get_config():
    with open(CONFIG_FILE, "r") as f:
        config = yaml.safe_load(f)
    return config


def update_config(config):
    with open(CONFIG_FILE, "w") as f:
        yaml.safe_dump(config, f)


# ===================================================


def _get_fetch_query() -> str:
    """
    Read the fetch query from the file.
    """
    fetch_query_path = FETCH_QUERY_PATH
    if not os.path.isabs(FETCH_QUERY_PATH):
        fetch_query_path = os.path.abspath(FETCH_QUERY_PATH)
    with open(fetch_query_path, "r") as f:
        query = f.read()
    return query


def fetch_helper(start_time: datetime, end_time: datetime):
    """
    Fetch data based on start_time and end_time.
    """
    print(f"Fetching data from {start_time} to {end_time}")
    sql_query = _get_fetch_query()
    query = text(sql_query).bindparams(start_time=start_time, end_time=end_time)

    with get_db() as session:
        try:
            result = session.execute(query)
            rows = result.fetchall()
            column_names = result.keys()
            df = pd.DataFrame(rows, columns=column_names)
            print(df.head())
            json_result = df.to_json(orient="records")
            return json.loads(json_result)
        except Exception as e:
            print(f"An error occurred: {e}")


def _group_data_by_sensor(data):
    grouped_data = defaultdict(list)

    for entry in data:
        sensor = entry["sensor_id"]
        timestamp = (
            entry["timestamp"].isoformat()
            if isinstance(entry["timestamp"], datetime)
            else entry["timestamp"]
        )
        value = entry["value"]

        grouped_data[sensor].append({"timestamp": timestamp, "value": value})

    return dict(grouped_data)


def post_data(start_time: datetime, end_time: datetime, sensor_data):
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {POST_API_KEY}",
    }
    grouped_data = _group_data_by_sensor(sensor_data)
    payload = {
        "start_time": start_time.isoformat(),
        "end_time": end_time.isoformat(),
        "data": grouped_data,
    }
    response = requests.post(POST_ENDPOINT_URL, json=payload, headers=headers)
    response.raise_for_status()
    message = {"status": "success", "message": "Data posted successfully"}
    print(message)
    return message


def main():
    config = get_config()
    last_push_time = config["last_push"]["batch_time"]
    current_time = datetime.now()

    start_time = datetime.fromisoformat(last_push_time)
    end_time = start_time + timedelta(minutes=BATCH_SIZE)
    if end_time < current_time:
        data = fetch_helper(start_time, end_time)
        if data:
            result = post_data(start_time, end_time, data)
            if result["status"] == "success":
                update_config(
                    {
                        "last_push": {
                            "batch_time": current_time.isoformat(),
                            "run_time": current_time.isoformat(),
                        }
                    }
                )
    else:
        print(
            f"Skipping data fetch and push as the last push was within the last {BATCH_SIZE} minutes."
        )


if __name__ == "__main__":
    main()
