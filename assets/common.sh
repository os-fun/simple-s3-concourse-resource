parse_source_config() {
  payload=$(mktemp /tmp/resource-in.XXXXXX)
  cat > $payload <&0
  URL=$(jq -r '.source.url // "https://kubernetes-charts.suse.com/"' $payload)
  RELEASE_NAME=$(jq -r '.source.release_name // "cf"' $payload)
  REPO_NAME=$(jq -r '.source.repo_name // "suse"' $payload)
  VERSION=$(jq -r '.version.ref // ""' $payload)
}
