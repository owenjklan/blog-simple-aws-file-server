import json
import boto3

BUCKET_NAME = "owenjklan-blog"

# boto3 is automatically in the Python Lambda environment
s3_client = boto3.client('s3')

def lambda_handler(event, context):
    path_params = event.get("pathParameters")

    if not path_params or not path_params["filename"]:
        return {
            'statusCode': 400,
            'body': json.dumps('No filename provided. Create an index!')
        }

    filename = path_params.get("filename")
    return {'statusCode': 200, 'body': json.dumps(f"You requested '{filename}'")}
