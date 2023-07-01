import pandas as pd
import os
import datetime
import em_locations


def iterateRange(sensor_name):
    data_df = pd.DataFrame()
    for i in range(60):
        try:

            df2 = pd.DataFrame(columns=['sensor_value'])  # Add columns and index, will get index error otherwise
            df2['sensor_value'] = pd.read_table(f'./ignore/data/{files}', index_col=False, delim_whitespace=True, header=None, usecols=[i], encoding='latin-1')

            #print(f"Sensor name before assignment: {sensor_name}")
            df2['sensor_name'] = sensor_name

            start_date = datetime.datetime(2018, 4, 26, 0, 0)
            end_date = start_date + datetime.timedelta(hours=2204)
            datetime_series = pd.date_range(start=start_date, end=end_date, freq='H')
            df2['date_time'] = datetime_series
            df2['cumulative_minutes'] = range(0,60*df2.shape[0], 60)

            df2['rig_name'] = f'{location}-{i + 1}'
        except Exception as e:
            print(f"Error processing data file: {e}")

        # Merge
        try:
            merge_df = pd.concat([profile_df, df2], axis=1)
            data_df = pd.concat([data_df, merge_df], ignore_index=True)
        except Exception as e:
            print(f"Error with merge: {e}")
    try:      
        today = datetime.date.today()
        csv_filename = f'{file_name}-{today}.csv'
        save_path = f'./ignore/locations/{location}/'
        data_df.to_csv(save_path+csv_filename,index=False, sep=',')
    except Exception as e:
        print(f"Error saving csv file: {e}")

# profile
try:
    profile_location = r'./ignore/profile/profile.txt'
    profile_df = pd.read_table(profile_location, index_col=False, header=None, delim_whitespace=True, encoding='latin-1')
    profile_columns = ['cooler_condition', 'valve_condition', 'internal_pump_leakage', 'hydraulic_accumulator_bar', 'stable_flag']
    profile_df.columns = profile_columns
    
except Exception as e:
    print(f"Error processing profile file: {e}")

# data
data_location = r'./ignore/data/'
rig_locations = em_locations.locations

for location in rig_locations:
    for files in os.listdir(path=data_location):
        file_name, file_ext = os.path.splitext(files)
        sensor_name = file_name # if using dated files, this will remove the date: [:-11]
        iterateRange(sensor_name)

print("CSV files complete")
