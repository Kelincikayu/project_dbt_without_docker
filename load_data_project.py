import os
import pandas as pd
import psycopg2
from sqlalchemy import create_engine

# Define your PostgreSQL connection parameters
params = {
    "host": "localhost",
    "database": "project2_kr",
    "user": "postgres",
    "password": "admin"
}

# Create a SQLAlchemy engine
engine = create_engine('postgresql+psycopg2://{}:{}@{}:5432/{}'.format(params["user"], params["password"], params["host"], params["database"]))

# Path to your CSV files
path = "C:\\Users\\lenovo\\graphql-compose-examples\\examples\\northwind\\data\\csv"

# Loop through all CSV files in the directory
for filename in os.listdir(path):
    if filename.endswith(".csv"):
        # Read CSV file into a pandas DataFrame
        df = pd.read_csv(os.path.join(path, filename))

        # Prepare SQL table name (remove .csv from filename)
        table_name = filename[:-4]

        # Write DataFrame to PostgreSQL table
        df.to_sql(table_name, engine, if_exists='replace', index=False)
