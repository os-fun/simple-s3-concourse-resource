# Simple s3 Concourse Resource

A Concourse CI resource to get latest files in a s3 bucket.

## Source Configuration
* `bucket`: s3 bucket name
* `bucket_subfolder:`: If files are in a subfolder, specify it here (`files/`)
* `filter`: grep format to filter out files
* `aws_access_key_id`: AWS access Key ID
* `aws_secret_access_key`: Aws secret access key
* `aws_default_region`: aws region

## Example

```
resource_types:
- name: simple-s3
  type: docker-image
  source:
      repository: splatform/concourse-simple-s3-resource
      tag: latest

resources:
- name: latest
  type: simple-s3
  source:
    bucket: "test"

jobs:
- name: get-it
  plan:
  - get: latest
    trigger: true
  - task: work
    config:
      run:
        ....
```

## Behaviour

### `check`: Check for new revisions

Checks the remote server for new versions.

### `in`: Fetch from build service

Downloads the latest uploaded file from the bucket.

### `out`: Not implemented
