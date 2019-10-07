parse_source_config() {
  URL=$(jq -r '.source.url // "https://kubernetes-charts.suse.com/"' $payload)
  RELEASE_NAME=$(jq -r '.source.release_name // "suse/cf"' $payload)
  VERSION=$(jq -r '.version.ref // ""' $payload)
}
