# Todo Manifests

Todo Manifests is used to provision K8s resources. It's based on Helm.

## Table of contents

- [How to create a release](#how-to-create-a-release)

## How to create a release

- Create a release to the folders ./releases

```bash
helm package . -d releases
```

- Update the index.yaml file

```bash
helm repo index .
```

> NOTES: after you did the above steps. Please commit the changes to the git repository. From now you can install you Helm Chart.

## Create repository for Elastic backup plugin

```bash
# Get password from K8s
set PASSWORD $(kubectl get secret elasticsearch-es-elastic-user -o jsonpath={.data.elastic} | base64 --decode)

# Add repository
curl -k -X PUT -u "elastic:$PASSWORD" https://localhost:9200/_snapshot/s3_snapshot \
                -H "Content-Type: application/json" \
                -d '{
              "type": "s3",
              "settings": {
                "client": "default",
                "bucket": "nonprod-es-snapshot",
                "region": "ap-southeast-1"
              }
            }'

# List repositories
curl -u -k "elastic:$PASSWORD" https://localhost:9200/_snapshot/s3_snapshot/_all
```
