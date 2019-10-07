# Helm Concourse Resource

A Concourse CI resource to interface with helm.
It can check any SCF helm repo for latest releases in a chart repository.

## Source Configuration

* `url`: URL of the SCF helm repository (optional).

## Example

```
resource_types:
- name: helm-resource
  type: docker-image
  source:
      repository: splatform/concourse-helm-resource
      tag: latest

resources:
- name: latest-helm-scf
  type: helm-resource

jobs:
- name: deploy-scf
  plan:
  - get: latest-helm-scf
    trigger: true
  - task: work
    config:
      run:
        ....
```

## Behaviour

### `check`: Check for new revisions

Checks the remote server for versions.

### `in`: Fetch from build service

Downloads and reassembles chart from remote server.

### `out`: Not implemented
