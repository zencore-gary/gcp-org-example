#!/bin/bash
set -euo pipefail

minikube start --kubernetes-version=1.29

# Gateway GA 1.0 CRDs
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.0.0/standard-install.yaml

# Cert-manager CRDs
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.6/cert-manager.crds.yaml

# External Secrets CRDs
kubectl apply -f https://raw.githubusercontent.com/external-secrets/external-secrets/v0.9.19/config/crds/bases/external-secrets.io_externalsecrets.yaml

# GKE Autopilot - Automatically deployed Managed Service for Prometheus CRDs
kubectl apply -f https://raw.githubusercontent.com/GoogleCloudPlatform/prometheus-engine/v0.10.0/manifests/setup.yaml
