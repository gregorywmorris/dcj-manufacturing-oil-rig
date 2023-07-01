from mysql.connector import connect
import os
import pandas as pd
import em_locations
# private file with sensitive data
import ignore.secrets as secrets

try:
    connection = connect(
        host='localhost',
        port= 33061,
        user= secrets.mysql_username,
        password= secrets.mysql_password,
        database='energymobile',
    )

    # object to exicute the sql queries
    my_cursor = connection.cursor()
except Exception as e:
    print(f"Error connecting: {e}")

try:
    csv_locations = em_locations.locations

    for location in csv_locations:
        
        data_location = f'./ignore/locations/{location}'

        for filename in os.listdir(data_location):
            csv_file_path = os.path.join(data_location, filename)
            df = pd.read_csv(csv_file_path)
            columns = df.columns.tolist()

            # Generate the placeholders for the SQL query
            placeholders = ', '.join(['%s'] * len(columns))

            # Generate the column names for the SQL query
            column_names = ', '.join(columns)

            # Generate the SQL query
            sql = f"INSERT INTO sensor_data ({column_names}) VALUES ({placeholders})"

            for row in df.itertuples(index=False):
                my_cursor.execute(sql, row)
except Exception as e:
    print(f"Error processing CSV: {e}")

    connection.commit()

    my_cursor.close()
    connection.close()
