#!/bin/bash


LATEST_VERSION=$(docker run --rm -i $IMAGE_NAME sh /opt/resource/check <<EOF
{
  "source": {
    "url": "https://kubernetes-charts.suse.com/",
    "relase_name": "cf"
  }
}
EOF
)

if [ -z "$LATEST_VERSION" ];
then
  echo "test failed"
  exit 1
fi