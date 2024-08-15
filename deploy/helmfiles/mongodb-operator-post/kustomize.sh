#!/bin/bash
set -e

current_dir=$(cd "$(dirname "${0}")" && pwd)
cd "${current_dir}"

cat <&0 > all.yaml
kubectl kustomize .
rm all.yaml
