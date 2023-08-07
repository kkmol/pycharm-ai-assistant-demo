# core library imports
import logging
import os

# external library imports
import boto3
import srsly

# local imports
# None

# create local logging stream to STDOUT, so it can be collected in cloudwatch
logger = logging.getLogger("lambda-python-template")
logger.setLevel(logging.DEBUG)
logger.addHandler(logging.StreamHandler())
logger.propagate = False


# default handler, the AWS Lambda function points to this function.
def handler(event, context):
    if event is None and context is None:
        logger.debug("Running in local mode")

    bucket_name = os.environ["S3_BUCKET_NAME"]
    object_name = (
        "machine_learning_event_data/Machine_Learning_Event_Data__jsonpath.json"
    )

    object = get_s3_object(bucket_name=bucket_name, object_name=object_name)

    mapping = srsly.json_loads(object)

    response = construct_response({"ml-events-handler-json-mapping": mapping})

    # function must return something JSON-serialisable
    return {"status": 200, "body": response}


def get_s3_object(bucket_name: str, object_name: str) -> dict:

    s3 = boto3.resource("s3")

    logger.info(f"Getting s3://{bucket_name}/{object_name}")
    object = s3.Object(bucket_name=bucket_name, key=object_name)

    return object.get()["Body"].read()


def construct_response(response_args: dict) -> dict:
    return {
        "Welcome to the data squad lamda python template": "Enjoy your stay",
        **response_args,
    }


# running mode for local testing, if the event or context is required.
# the variables can be built within a seperate function.
if __name__ == "__main__":
    print(handler(None, None))
