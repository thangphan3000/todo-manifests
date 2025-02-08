# Todo manifests

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
