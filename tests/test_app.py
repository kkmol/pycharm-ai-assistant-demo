import os
from unittest.mock import patch

import pytest
import srsly

from src.app import construct_response, get_s3_object, handler


def test_construct_response():

    additional_data = {"dict": "key"}

    assert construct_response(additional_data) == {
        "Welcome to the data squad lamda python template": "Enjoy your stay",
        "dict": "key",
    }


@patch("src.app.boto3")
def test_get_s3_object_mock(boto3):
    _ = get_s3_object(bucket_name="bucket", object_name="key")

    boto3.resource.assert_called_with("s3")
    boto3.resource().Object.assert_called_with(bucket_name="bucket", key="key")
    boto3.resource().Object().get.assert_called()


@pytest.mark.integtest
def test_get_s3_object():
    response = get_s3_object(
        bucket_name="zuto-datalake-raw-ml",
        object_name="machine_learning_event_data/Machine_Learning_Event_Data__jsonpath.json",
    )

    assert isinstance(response, bytes)
    assert isinstance(srsly.json_loads(response), dict)


@patch("src.app.get_s3_object")
@patch.dict(os.environ, {"S3_BUCKET_NAME": "le buc"})
def test_handler_mock(get_s3_object):
    get_s3_object.return_value = srsly.json_dumps({"dict": "key"}).encode("utf-8")

    response = handler(None, None)

    assert isinstance(response, dict)
    assert list(response.keys()) == ["status", "body"]
    assert response["status"] == 200
    assert response["body"]["ml-events-handler-json-mapping"]["dict"] == "key"


@pytest.mark.integtest
def test_handler():
    response = handler(None, None)
    assert isinstance(response, dict)
    assert list(response.keys()) == ["status", "body"]
    assert response["status"] == 200
