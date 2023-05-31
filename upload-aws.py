import boto3
import os
import ignore.secrets as secrets


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
csv_directory = './logs/'
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