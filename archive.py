import os
import shutil


# Archive files
aws_directory = './aws_s3/'
aws_archive = './aws_s3/archive/'

if not os.path.exists(aws_archive):
    os.makedirs(aws_archive)

for filename in os.listdir(aws_directory):
    source_file = os.path.join(aws_directory, filename)
    destination_folder = aws_archive
    shutil.move(source_file, destination_folder)

logs_directory = './logs/'
logs_archive = './logs/archive/'
for filename in os.listdir(logs_directory):
    source_file = os.path.join(logs_directory, filename)
    destination_folder = logs_archive
    shutil.move(source_file, destination_folder)