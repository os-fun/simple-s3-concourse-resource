#!/bin/bash
set -xe

docker run -i --rm -v $PWD:/output $IMAGE_NAME sh /opt/resource/in /output <<EOF
{
  "source": {
    "url": "https://kubernetes-charts.suse.com/",
    "relase_name": "cf"
  }
}
EOF

CHART=$(ls *.zip)

if [ -z "$CHART" ]; then
  echo "no chart could be fetched"
  exit 1
fi

rm -rf *.zip *.tgz

docker run --rm -i -v $PWD:/output $IMAGE_NAME sh /opt/resource/in /output <<EOF
{
  "version": { "ref": "2.17.1" },
  "source": {
    "url": "https://kubernetes-charts.suse.com/",
    "relase_name": "cf"
  }
}
EOF

CHART=$(ls *2.17.1*.zip)

if [ -z "$CHART" ]; then
  echo "no chart could be fetched"
  exit 1
fi
