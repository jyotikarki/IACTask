import os
from google.cloud import bigquery
import pandas as pd

# Set up BigQuery client
def setup_bigquery_client():
    return bigquery.Client()

# Extract data from BigQuery
def extract_data(client, input_dataset_id, input_table_id):
    query = f"""
    SELECT * FROM `{input_dataset_id}.{input_table_id}`
    """
    query_job = client.query(query)
    results = query_job.result()
    return results.to_dataframe()

# Transform data (example transformation)
def transform_data(data):
    # Example: Add a new column with transformed data
    data['new_column'] = data['existing_column'].apply(lambda x: x * 2)
    return data

# Load data into BigQuery
def load_data(client, data, output_dataset_id, output_table_id):
    table_id = f"{output_dataset_id}.{output_table_id}"
    job = client.load_table_from_dataframe(data, table_id)
    job.result()  # Wait for the job to complete

def main():
    # Set up environment variables for authentication (assuming you have the credentials file)
    os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = 'path/to/your/credentials.json'

    # Define your dataset and table IDs
    input_dataset_id = 'your_input_dataset_id'
    input_table_id = 'your_input_table_id'
    output_dataset_id = 'your_output_dataset_id'
    output_table_id = 'your_output_table_id'

    # Set up BigQuery client
    client = setup_bigquery_client()

    # Extract data from BigQuery
    data = extract_data(client, input_dataset_id, input_table_id)
    print("Data extracted successfully.")

    # Transform data
    transformed_data = transform_data(data)
    print("Data transformed successfully.")

    # Load data into BigQuery
    load_data(client, transformed_data, output_dataset_id, output_table_id)
    print("Data loaded successfully into the output table.")

if __name__ == "__main__":
    main()
    