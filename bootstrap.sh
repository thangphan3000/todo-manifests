#!/bin/bash

set -e

apply_manifest_file() {
  local file=$1
  if [[ -f "$file" ]]; then
    echo "[INFO] Applying $file"
    kubectl apply -f "$file"
  else
    echo "[ERROR] $file not found"
  fi
}

restart_sealed_secrets() {
  echo "[INFO] Restarting sealed-secrets pod"
  kubectl delete pod -n sealed-secrets -l app.kubernetes.io/name=sealed-secrets
}

main() {
  echo "[INFO] Bootstrap starting..."

  apply_manifest_file "master.key"
  restart_sealed_secrets
  apply_manifest_file "gitops-repo-sealed-secret.yaml"
  apply_manifest_file "apps-dev.yaml"

  echo "[INFO] Bootstrap completed!"
}

main
