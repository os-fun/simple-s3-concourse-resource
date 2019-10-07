#!/bin/bash

set -e

HELM_VERSION="$1"
HELM_REPO="${HELM_REPO:-https://kubernetes-charts.suse.com/}"
rm -rf tmp || true

mkdir tmp
pushd tmp
  export HELM_HOME="$(pwd)"/.helm
  helm init --client-only
  helm repo add suse $HELM_REPO
  helm repo update

  if [ -n "$HELM_VERSION" ]; then

    helm fetch suse/cf --version $HELM_VERSION
    helm fetch suse/uaa --version $HELM_VERSION

  else

    helm fetch suse/cf
    helm fetch suse/uaa

  fi

  mkdir -p charts/helm
  tar xvf cf-*.tgz -C charts/helm
  tar xvf uaa-*.tgz -C charts/helm
  pushd charts
  VERSION=$(yq r helm/cf/Chart.yaml version)
  API_VERSION=$(yq r helm/cf/Chart.yaml apiVersion)

  if [ -z "$VERSION" ]; then
    echo "No version found from the chart"
    exit 1
  fi

  if [ -z "$API_VERSION" ]; then
    echo "No api version found from the chart"
    exit 1
  fi
  echo "Producing bundle for $API_VERSION - $VERSION"
  tar cvzf ../../scf-sle-${API_VERSION}.tgz *
  zip -r9 ../../scf-sle-${API_VERSION}.zip -- *
  popd
popd

rm -rf tmp

echo "$VERSION" > dist_version
echo "$API_VERSION" > dist_api_version