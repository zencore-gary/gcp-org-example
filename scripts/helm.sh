#!/bin/bash

### Helm public repositories

helm repo add argo https://argoproj.github.io/argo-helm
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add cert-manager https://charts.jetstack.io
helm repo add external-secrets https://charts.external-secrets.io
helm repo add mongodb https://mongodb.github.io/helm-charts

### System services

helm -n cert-manager install cert-manager cert-manager/cert-manager --version 1.14.7 \
  --values deploy/blockapt/values/dev/cert-manager.yaml --create-namespace --wait

kubectl apply -f deploy/blockapt/manifests/dev/2-clusterissuers.yaml

helm -n external-secrets install external-secrets external-secrets/external-secrets --version 0.9.20 \
  --values deploy/blockapt/values/dev/external-secrets.yaml --create-namespace --wait

kubectl apply -f deploy/blockapt/manifests/dev/2-clustersecretstore.yaml

helm -n mongodb-operator install mongodb-operator mongodb/community-operator --version 0.10.0 \
  --values deploy/blockapt/values/dev/mongodb-operator.yaml --create-namespace --wait

kubectl create ns blockapt
kubectl apply -f deploy/blockapt/manifests/dev/2-mongodb-ce.yaml

### Upgrades

helm -n cert-manager upgrade cert-manager cert-manager/cert-manager \
  --version 1.14.7 --values deploy/blockapt/values/dev/cert-manager.yaml --wait

helm -n external-secrets upgrade external-secrets external-secrets/external-secrets \
  --version 0.9.19 --valuesdeploy/blockapt/values/dev/external-secrets.yaml --wait

helm -n mongodb upgrade community-operator mongodb/community-operator \
  --version 0.9.0 --values deploy/blockapt/values/dev/mongodb-operator.yaml --wait

### BlockAPT

helm -n blockapt upgrade master deploy/charts/blockapt/ --values deploy/blockapt/values/dev/master.yaml --install

helm -n blockapt upgrade logger deploy/charts/blockapt/ --values deploy/blockapt/values/dev/logger.yaml --install

helm -n blockapt upgrade search-logger deploy/charts/blockapt/ --values deploy/blockapt/values/dev/search-logger.yaml --install

helm -n blockapt upgrade graphs deploy/charts/blockapt/ --values deploy/blockapt/values/dev/graphs.yaml --install

helm -n blockapt upgrade socket deploy/charts/blockapt/ --values deploy/blockapt/values/dev/socket.yaml --install

helm -n blockapt upgrade pdf deploy/charts/blockapt/ --values deploy/blockapt/values/dev/pdf.yaml --install

helm -n blockapt upgrade mte deploy/charts/blockapt/ --values deploy/blockapt/values/dev/mte.yaml --install
