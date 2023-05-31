import boto3
import pandas as pd
import os
import ignore.secrets as secrets

os.environ["AWS_DEFAULT_REGION"] = 'us-east-2'
os.environ["AWS_ACCESS_KEY_ID"] = secrets.AWS_ACCESS_KEY_ID
os.environ["AWS_SECRET_ACCESS_KEY"] = secrets.AWS_SECRET_ACCESS_KEY

csv_directory = './data/'
target_bucket = 'well-logs'
for filename in os.listdir(csv_directory):
    s3.Bucket(target_bucket).upload_file(Filename=filename, Key=filename)

# Confirm successful upload
for obj in s3.Bucket(target_bucket).objects.all():
    print(obj)