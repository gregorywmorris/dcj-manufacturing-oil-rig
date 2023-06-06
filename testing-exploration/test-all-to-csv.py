import pandas as pd
import os
import datetime


data_location = './data/'

for files in os.listdir(path=data_location):
    file_name, file_ext = os.path.splitext(files)
    df = pd.DataFrame()
    for i in range(60):
        df2 = pd.DataFrame(columns=['sensor_value'])
        df2['sensor_value'] = pd.read_table(os.path.join(data_location, files), index_col=False, delim_whitespace=True, header=None, usecols=[i], encoding='latin-1')
        df2['sensor_name'] = file_name
        df2['cohort'] = [i + 1 for cohort in range(df2.shape[0])]
        start_date = datetime.datetime(2008, 3, 26, 0, 0)
        timedelta_per_iteration = datetime.timedelta(days=92 * i)
        start_date_updated = start_date + timedelta_per_iteration
        end_date_updated = start_date_updated + datetime.timedelta(hours=2204)
        start_date = start_date_updated
        end_date = end_date_updated
        datetime_series = pd.date_range(start=start_date, end=end_date, freq='H')
        df2['date_time'] = datetime_series
        df2['cumulative_minutes'] = range(0, 60 * df2.shape[0], 60)
        df2['target_condition'] = range(1, 1 + df2.shape[0])
        df = pd.concat([df, df2], ignore_index=True)
        df2.drop(df2.iloc[0:0], axis=1, inplace=True)
    df.columns = [x.lower() for x in df.columns]
    csv_filename = f'{file_name}.csv'
    df.to_csv(os.path.join(r'./logs/', csv_filename), index=False)

profile_location = './profile/'

for files in os.listdir(path=profile_location):
    df = pd.read_table(os.path.join(profile_location, files), index_col=False, delim_whitespace=True, header=None)
    profile_columns = ['cooler_condition', 'valve_condition', 'internal_pump_leakage', 'hydraulic_accumulator_bar', 'stable_flag']
    df.columns = profile_columns
    csv_filename = f'target_condition.csv'
    df.to_csv(os.path.join(r'./logs/', csv_filename), index=False)

# merge csv files
csv_location = './logs/'
merged_data = pd.DataFrame()

for files in os.listdir(path=csv_location):
    df = pd.read_csv(os.path.join(csv_location, files))
    merged_data = merged_data.append(df, ignore_index=True)

merged_csv_path = r'./merged/merged_data.csv'
merged_data.to_csv(merged_csv_path, index=False)

print("CSV files merged successfully!")
