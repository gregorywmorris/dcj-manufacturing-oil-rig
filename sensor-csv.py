import pandas as pd
import os
import datetime


# pull read the txt files and create csv files
p = r'./data/'

for files in os.listdir(path=p): 
    for i in range(60):
        var_dict = {}
        start_date = datetime.datetime(2008,3,26,0,0)
        # Calculate the timedelta for each iteration
        timedelta_per_iteration = datetime.timedelta(days=92 * i) 

        # Update the start_date by adding the timedelta
        start_date_updated = start_date + timedelta_per_iteration

        # Calculate the end_date based on the updated start_date
        end_date_updated = start_date_updated + datetime.timedelta(hours=2204)
        # update times for each iteration
        start_date = start_date_updated
        end_date = end_date_updated
    
        file_name, file_ext = os.path.splitext(files)
        
        var_dict[file_name] = pd.read_table(f'./data/{files}', index_col=False, delim_whitespace=True, header=None,usecols=[i],encoding='latin-1')
        
        var_dict[file_name] = var_dict[file_name].stack()

        df = pd.DataFrame.from_dict(var_dict)

        # demarcate the 1 hour iteration across the entire tracking period
        df['cumulative_minutes'] = range(0, 0 + (60 * df.shape[0]), 60)

        # demarcate cohort for each of the 60 test periods
        df['cohort'] = [i+1 for cohort in range(df.shape[0])]

        # Create a datetime series
        datetime_series = pd.date_range(start=start_date, end=end_date, freq='H')
        df['date_time'] = datetime_series

        # oil well condition
        profile_df = pd.read_table(r'./outcomes/profile.txt', index_col=False, delim_whitespace=True,header=None)

        profile_columns = ['cooler_condition','valve_condition','internal_pump_leakage','hydrolic_acucumlator_bar','stable_flag']

        profile_df.columns = profile_columns

        for c in profile_columns:
            df[c]= profile_df[c].values

        # normalize  column headers
        df.columns = [x.lower() for x in df.columns]

        #export
        #TodaysDate = time.strftime('%d-%m-%Y') #use for interval updates
        csv_filename = f'{files}.csv'

        df.to_csv(r'./logs/'+csv_filename, index=False)
