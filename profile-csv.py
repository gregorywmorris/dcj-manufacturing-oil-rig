import pandas as pd
import os

data_location = './profile/'

for files in os.listdir(path=data_location):
    df = pd.read_table(os.path.join(data_location, files), index_col=False, header=None, delim_whitespace=True, encoding='latin-1')
    profile_columns = ['cooler_condition', 'valve_condition', 'internal_pump_leakage', 'hydraulic_accumulator_bar', 'stable_flag']
    df.columns = profile_columns

    # export
    csv_filename = f'target_condition.csv'
    df.to_csv('./logs/' + csv_filename, index=False)