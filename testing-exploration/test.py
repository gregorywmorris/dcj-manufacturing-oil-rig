import pandas as pd
import os


# merge csv files
csv_location = './logs/'
merged_data = pd.DataFrame()

for file in os.listdir(csv_location):
    file_path = os.path.join(csv_location, file)
    if os.path.isfile(file_path) and file.endswith('.csv'):
        df = pd.read_csv(file_path)
        merged_data = pd.concat([merged_data, df], ignore_index=True)

merged_csv_path = './merged/merged_data.csv'
merged_data.to_csv(merged_csv_path, index=False)

print("CSV files merged successfully!")
