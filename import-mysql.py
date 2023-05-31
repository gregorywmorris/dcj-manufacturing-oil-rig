from mysql.connector import connect
import os
import pandas as pd
# private file with sensitive data
import ignore.secrets as secrets

connection = connect(
    host='localhost',
    user= secrets.mysql_username,
    password= secrets.mysql_password,
    database='your_database'
)

# object to exicute the sql queries
cursor = connection.cursor()

csv_directory = './data/'

for filename in os.listdir(csv_directory):
    if filename.endswith('.csv'):
        csv_file_path = os.path.join(csv_directory, filename)

        # Read the CSV file into a pandas DataFrame
        df = pd.read_csv(csv_file_path)

        # Get the column names from the DataFrame
        columns = df.columns.tolist()

        # Generate the placeholders for the SQL query
        placeholders = ', '.join(['%s'] * len(columns))

        # Generate the column names for the SQL query
        column_names = ', '.join(columns)

        # Generate the SQL query
        sql = f"INSERT INTO your_table ({column_names}) VALUES ({placeholders})"

        # Iterate over the rows in the DataFrame
        for row in df.itertuples(index=False):
            # Execute the SQL query for each row
            cursor.execute(sql, row)

connection.commit()

cursor.close()
connection.close()