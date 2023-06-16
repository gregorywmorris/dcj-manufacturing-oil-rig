import pandas as pd
import os
import datetime


def iterateRange(files,file_name,name,data_df):
    for i in range(60):
        df2 = pd.DataFrame(columns=['sensor_value'])  # Add columns and index, will get index error otherwise
        df2['sensor_value'] = pd.read_table(f'./ignore/texas/data/{files}', index_col=False, delim_whitespace=True, header=None, usecols=[i], encoding='latin-1')
        df2['sensor_name'] = name

        start_date = datetime.datetime(2018, 4, 26, 0, 0)
        end_date = start_date + datetime.timedelta(hours=2204)
        datetime_series = pd.date_range(start=start_date, end=end_date, freq='H')
        df2['date_time'] = datetime_series
        df2['cumulative_minutes'] = range(0,60*df2.shape[0], 60)

        df2['well_number'] = i + 1

        # Merge
        merge_df = pd.concat([profile_df, df2], axis=1)
        data_df = pd.concat([data_df, merge_df], ignore_index=True)

    today = datetime.date.today()
    csv_filename = f'{file_name}.csv'
    data_df.to_csv(r'./ignore/texas/data-csv/' + csv_filename, index=False)


# profile
profile_location = r'./profile/profile.txt'
profile_df = pd.read_table(profile_location, index_col=False, header=None, delim_whitespace=True, encoding='latin-1')
profile_columns = ['cooler_condition', 'valve_condition', 'internal_pump_leakage', 'hydraulic_accumulator_bar', 'stable_flag']
profile_df.columns = profile_columns

# data
data_location = r'./ignore/texas/data/'

for files in os.listdir(path=data_location):
    file_name, file_ext = os.path.splitext(files)
    name = file_name[:-11]
    data_df = pd.DataFrame()
    iterateRange(files,file_name,name,data_df)

print("CSV files complete")
