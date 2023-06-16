import os
import datetime


locations = ['california', 'texas']

today = datetime.date.today()

for location in locations:
    data_location = f'./ignore/{location}/data/'
    for files in os.listdir(path=data_location):
        file_name, file_ext = os.path.splitext(files)

        file_path = os.path.join(data_location, files)
        new_file_name = f'{file_name}-{today}.txt'
        new_file_path = os.path.join(data_location, new_file_name)

        os.rename(file_path, new_file_path)