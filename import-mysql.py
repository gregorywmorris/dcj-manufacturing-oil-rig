from mysql.connector import connect
import os
import pandas as pd
# private file with sensitive data
import ignore.secrets as secrets

connection = connect(
    host='localhost',
    user= secrets.mysql_username,
    password= secrets.mysql_password,
    database='energymobile',
)

# object to exicute the sql queries
cursor = connection.cursor()

profile_directory = './profile/'

for filename in os.listdir(profile_directory):
    if filename.endswith('.csv'):
        csv_file_path = os.path.join(profile_directory, filename)
        file_name, file_ext = os.path.splitext(filename)
        # Read the CSV file into a pandas DataFrame
        df = pd.read_csv(csv_file_path)

        # Get the column names from the DataFrame
        columns = df.columns.tolist()

        # Generate the placeholders for the SQL query
        placeholders = ', '.join(['%s'] * len(columns))

        # Generate the column names for the SQL query
        column_names = ', '.join(columns)

        # Generate the SQL query
        sql = f"INSERT INTO profile ({column_names}) VALUES ({placeholders})"

        # Iterate over the rows in the DataFrame
        for row in df.itertuples(index=False):
            # Execute the SQL query for each row
            cursor.execute(sql, row)


logs_directory = './logs/'

for filename in os.listdir(logs_directory):
    if filename.endswith('.csv'):
        csv_file_path = os.path.join(logs_directory, filename)
        file_name, file_ext = os.path.splitext(filename)
        # Read the CSV file into a pandas DataFrame
        df = pd.read_csv(csv_file_path)

        # Get the column names from the DataFrame
        columns = df.columns.tolist()

        # Generate the placeholders for the SQL query
        placeholders = ', '.join(['%s'] * len(columns))

        # Generate the column names for the SQL query
        column_names = ', '.join(columns)

        # Generate the SQL query
        sql = f"INSERT INTO sensor_data ({column_names}) VALUES ({placeholders})"

        # Iterate over the rows in the DataFrame
        for row in df.itertuples(index=False):
            # Execute the SQL query for each row
            cursor.execute(sql, row)

connection.commit()

cursor.close()
connection.close()