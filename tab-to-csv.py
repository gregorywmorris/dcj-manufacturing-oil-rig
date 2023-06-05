import pandas as pd
import os
import datetime

data_location = r'./data/'

for files in os.listdir(path=data_location):
    file_name, file_ext = os.path.splitext(files)
    df = pd.DataFrame()
    for i in range(60):
        df2 = pd.DataFrame(columns=['sensor_value'])  # Add columns and index, will get index error otherwise

        df2['sensor_value'] = pd.read_table(f'./data/{files}', index_col=False, delim_whitespace=True, header=None, usecols=[i], encoding='latin-1')

        df2['sensor_name'] = file_name

        # insert the value of 1 and increase by 1 for every rows
        df2['cohort'] = [i + 1 for cohort in range(df2.shape[0])]

        # Create a datetime series
        start_date = datetime.datetime(2008, 3, 26, 0, 0)
        timedelta_per_iteration = datetime.timedelta(days=92 * i)
        start_date_updated = start_date + timedelta_per_iteration
        end_date_updated = start_date_updated + datetime.timedelta(hours=2204)
        # update times for each iteration
        start_date = start_date_updated
        end_date = end_date_updated
        datetime_series = pd.date_range(start=start_date, end=end_date, freq='H')

        df2['date_time'] = datetime_series

        # demarcate the 1 hour iteration across the entire tracking period
        df2['cumulative_minutes'] = range(0,60*df2.shape[0], 60)

        # map with data in profile.txt
        df2['target_condition'] = range(1,1+df2.shape[0])

        # merge and drop
        df = pd.concat([df, df2], ignore_index=True)
        df2.drop(df2.iloc[0:0], axis=1, inplace=True)

    df.columns = [x.lower() for x in df.columns]

    # export
    today = datetime.date.today()
    csv_filename = f'{file_name}-{today}.csv'
    df.to_csv(r'./logs/' + csv_filename, index=False)
