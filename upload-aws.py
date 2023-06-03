import boto3
import os
import ignore.secrets as secrets
import shutil


# establish a connection
s3 = boto3.client(
    's3', 
    region_name='us-east-1', 
    aws_access_key_id=secrets.AWS_ACCESS_KEY_ID, 
    aws_secret_access_key=secrets.AWS_SECRET_ACCESS_KEY
)

#Create bucket
bucket_name = 'well-logs'

response = s3.create_bucket(
    Bucket=bucket_name
)

print(response)

# upload files
csv_directory = './aws_s3/'
for filename in os.listdir(csv_directory):
    file_path = os.path.join(csv_directory, filename)
    s3.upload_file(file_path, bucket_name, filename)

# Confirm successful upload
response = s3.list_objects(Bucket=bucket_name)
objects = response.get('Contents', [])
if objects:
    for obj in objects:
        print(obj['Key'])
else:
    print("No objects found in the bucket.")

# Archive files
home_directory = './aws_s3/'
archive_directory = './aws_s3/archive/'

if not os.path.exists(archive_directory):
    os.makedirs(archive_directory)

for filename in os.listdir(home_directory):
    source_file = os.path.join(home_directory, filename)
    destination_folder = archive_directory
    shutil.move(source_file, destination_folder)