#!/bin/bash
set -xe

docker run -i --rm -v $PWD/testtmp:/output $IMAGE_NAME sh /opt/resource/in /output <<EOF
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

CHART=$(ls testtmp/*.tgz)

if [ -z "$CHART" ]; then
  echo "no chart could be fetched"
  exit 1
fi

docker run --rm -i -v $PWD/testtmp2:/output $IMAGE_NAME sh /opt/resource/in /output <<EOF
{
  "version": { "ref": "2019-10-10 12:17:26" },
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

CHART=$(ls testtmp2/scf-3.0.0-50e819a.tgz)

if [ -z "$CHART" ]; then
  echo "no chart could be fetched"
  exit 1
fi
