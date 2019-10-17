#!/bin/bash

LATEST_VERSION=$(docker run --rm -i $IMAGE_NAME sh /opt/resource/check <<EOF
{
  "source": {
    "bucket": "scf-v3",
    "bucket_subfolder": "",
    "filter": "tgz",
    "aws_access_key_id": "$AWS_KEY_ID",
    "aws_secret_access_key": "$AWS_SECRET_ACCESS_KEY",
    "aws_default_region": "us-east-1"
  }
}
EOF
)

echo $LATEST_VERSION
if [ -z "$LATEST_VERSION" ];
then
  echo "test failed"
  exit 1
fi