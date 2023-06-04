# Archive files
home_directory = './aws_s3/'
archive_directory = './aws_s3/archive/'

if not os.path.exists(archive_directory):
    os.makedirs(archive_directory)

for filename in os.listdir(home_directory):
    source_file = os.path.join(home_directory, filename)
    destination_folder = archive_directory
    shutil.move(source_file, destination_folder)