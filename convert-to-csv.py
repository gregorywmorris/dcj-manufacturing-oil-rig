import pandas as pd
import os
import datetime

# pull read the txt files and create a single csv file
p = r'./data/'
var_dict = {}

for files in os.listdir(path=p):
    file_name, file_ext = os.path.splitext(files)
    df = pd.read_table(f'./data/{files}', index_col=False, delim_whitespace=True, header=None, encoding='latin-1')

    # stack the columns vertically
    df_stacked = df.stack()

    # add the stacked data to the dictionary
    var_dict[file_name] = df_stacked

# create a DataFrame from the dictionary
df = pd.DataFrame.from_dict(var_dict)

# calculate the total number of rows
total_rows = df.shape[0]

# demarcate the 1-hour iteration across the entire tracking period
df['cumulative_minutes'] = range(0, 0 + (60 * total_rows), 60)

# insert the value of 1 and increase by 1 for every 2205 rows
df['cohort'] = [(row // 2205) + 1 for row in range(total_rows)]

# create a datetime series
start_date = datetime.datetime(2008, 3, 26, 0, 0)
end_date = start_date + datetime.timedelta(hours=(total_rows // 60) - 1)
datetime_series = pd.date_range(start=start_date, end=end_date, freq='H')

# adjust the datetime series to match the number of rows in the DataFrame
datetime_series = datetime_series[:total_rows % 2205]

df['date_time'] = datetime_series.repeat(2205)

# read the profile.txt file for additional columns
profile_df = pd.read_table(r'./outcomes/profile.txt', index_col=False, delim_whitespace=True, header=None)
profile_columns = ['cooler_condition', 'valve_condition', 'internal_pump_leakage', 'hydraulic_accumulator_bar', 'stable_flag']
profile_df.columns = profile_columns

# add the profile columns to the main DataFrame
for c in profile_columns:
    df[c] = profile_df[c].values

# normalize column headers
df.columns = [x.lower() for x in df.columns]

# export the DataFrame to a CSV file
csv_filename = f'all_data.csv'
df.to_csv(r'./logs/' + csv_filename, index=False)
