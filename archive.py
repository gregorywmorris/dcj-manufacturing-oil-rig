import os
import shutil


# Archive files
aws_directory = './aws_s3/'
archive = './archive/'

for filename in os.listdir(aws_directory):
    source_file = os.path.join(aws_directory, filename)
    destination_folder = archive
    shutil.move(source_file, destination_folder)

logs_directory = './logs/'
for filename in os.listdir(logs_directory):
    source_file = os.path.join(logs_directory, filename)
    destination_folder = archive
    shutil.move(source_file, destination_folder)