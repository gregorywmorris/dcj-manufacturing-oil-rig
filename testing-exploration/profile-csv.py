import pandas as pd
import os
import datetime


data_location = '.ignore/profile/'

for files in os.listdir(path=data_location):
    if files.endswith('.txt'):
        file_name, file_ext = os.path.splitext(files)
        df = pd.read_table(os.path.join(data_location, files), index_col=False, header=None, delim_whitespace=True, encoding='latin-1')
        profile_columns = ['cooler_condition', 'valve_condition', 'internal_pump_leakage', 'hydraulic_accumulator_bar', 'stable_flag']
        df.columns = profile_columns

        # export
        today = datetime.date.today()
        csv_filename = f'{file_name}-{today}.csv'
        df.to_csv('.ignore/profile/' + csv_filename, index=False)