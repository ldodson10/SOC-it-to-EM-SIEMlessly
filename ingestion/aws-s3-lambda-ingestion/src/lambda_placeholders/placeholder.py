import json

def lambda_handler(event, context):
    print("This is a placeholder function.")
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }