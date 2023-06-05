import boto3
import os
import ignore.secrets as secrets


# Establish a connection
s3 = boto3.client(
    's3',
    region_name='us-east-1',
    aws_access_key_id=secrets.AWS_ACCESS_KEY_ID,
    aws_secret_access_key=secrets.AWS_SECRET_ACCESS_KEY
)

# Upload files
csv_directory = './aws_s3/'
bucket_name = 'well-sensor-logs'

for root, dirs, files in os.walk(csv_directory):
    for filename in files:
        file_path = os.path.join(root, filename)
        s3.upload_file(file_path, bucket_name, filename)

# Confirm successful upload
response = s3.list_objects(Bucket=bucket_name)
objects = response.get('Contents', [])
if objects:
    for obj in objects:
        print(obj['Key'])
else:
    print("No objects found in the bucket.")