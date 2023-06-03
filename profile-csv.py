import pandas as pd
import os

data_location = r'./profile/'

for files in os.listdir(path=data_location):
    file_name, file_ext = os.path.splitext(files)
    df = pd.read_table(f'./outcomes/{files}', index_col=False, delim_whitespace=True, header=None)
    profile_columns = ['cooler_condition', 'valve_condition', 'internal_pump_leakage', 'hydrolic_acucumlator_bar', 'stable_flag']
    df.columns = profile_columns

    # export
    csv_filename = f'{file_name}.csv'
    df.to_csv(r'./profile/' + csv_filename, index=False)