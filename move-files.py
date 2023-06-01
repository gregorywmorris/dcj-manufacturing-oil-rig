import shutil
import os

home_directory = './logs/'
new_location = './logs/archive/'

for filename in os.listdir(home_directory):
    source_file = os.path.join(home_directory, filename)
    destination_folder = new_location
    shutil.move(source_file, destination_folder)