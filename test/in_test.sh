#!/bin/bash
set -xe

docker run --rm -v $PWD:/output $IMAGE_NAME sh /opt/resource/in /output <<EOF
{
  "source": {
    "url": "https://kubernetes-charts.suse.com/",
    "relase_name": "cf"
  },
}
EOF

CHART=$(ls *.zip)

if [ -z "$CHART" ]; then
  echo "no chart could be fetched"
  exit 1
fi
