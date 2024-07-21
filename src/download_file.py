import json
import boto3

BUCKET_NAME = "owenjklan-blog"

# boto3 is automatically in the Python Lambda environment
s3_client = boto3.client('s3')

def lambda_handler(event, context):
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }