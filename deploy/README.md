# Deployment to Kubernetes

---
## Helm charts

Target oldest Kubernetes supported version from your Cloud provider

### Prerequisites

- [Kubernetes `1.25+`](https://kubernetes.io/releases/)
- [Helm `3.10+`](https://helm.sh/)
- [Bitnami's Readme Generator For Helm `2.6.0`](https://github.com/bitnami/readme-generator-for-helm)
- Enabling `PodMonitor` or `ServiceMonitor` requires [Prometheus Operator CRDs](https://artifacthub.io/packages/helm/prometheus-community/prometheus-operator-crds)
- Enabling `ExternalSecret` requires [External-secrets CRDs](https://github.com/external-secrets/external-secrets/tree/main/deploy/crds)

---
## Deploy with ArgoCD

SSH in to the bastion and get Kubernetes CLI credentials for the GKE cluster.

#### Initial setup

* Quick install in to Kubernetes using values from [`blockapt/values/argocd.yaml`](./blockapt/values/argocd.yaml)

  ```bash
  kubectl create ns argo
  kubectl label  ns argo shared-gateway-access=true
  # Add Helm chart repository
  helm repo add argo https://argoproj.github.io/argo-helm
  # Helm chart install -- (argocd.yaml is in the repository, move it to bastion first)
  helm -n argo install argocd oci://ghcr.io/argoproj/argo-helm/argo-cd \
    --values ./argocd.yaml --wait
  ```

* [Install CLI](https://argo-cd.readthedocs.io/en/stable/cli_installation/)

  ```bash
  # CLI default options
  export ARGOCD_OPTS='--insecure --plaintext --port-forward --port-forward-namespace argo'

  # Get password and login using CLI
  ARGOCD_PASSWORD=$(kubectl -n argo get secret argocd-initial-admin-secret -o jsonpath="{.data['password']}" | base64 -d)
  argocd login server --username admin --password="${ARGOCD_PASSWORD}"
  ```

* Create an SSH deploy key for the repository in GitHub (you can fetch it from the GCP Secret Manager and save it in bastion)

* [Add private repository (GitOps)](https://argo-cd.readthedocs.io/en/stable/user-guide/private-repositories/)

  ```bash
  argocd repo add git@github.com:zencore-dev/blockapt-infra.git --ssh-private-key-path ./deploy.key
  ```

* Apply the `0-main.yaml` manifest to deploy the `main` application, it will also deploy everything else. [(Argo CD app of apps pattern)](https://argo-cd.readthedocs.io/en/stable/operator-manual/cluster-bootstrapping/#app-of-apps-pattern)

  > TODO: you might encounter errors because of ordering problems,
  some manifests use Custom Resource Definitions (CRDs) from Cert-manager or External-secrets
  and require that they are already available to be applied

#### Access UI

Exposed via a [GKE Gateway](blockapt/manifests/dev/4-expose.yaml)

#### Upgrade Argo CD

```bash
helm repo update
helm -n argo upgrade argocd argo/argo-cd --version <x.y.z> --values argocd.yaml
```

---
## Notes

### Cert-manager

https://cert-manager.io/
https://artifacthub.io/packages/helm/cert-manager/cert-manager

* GKE autopilot cluster require the extra set with `global.leaderElection.namespace=cert-manager` 
to avoid permission errors on namespace `kube-system`:
https://cert-manager.io/docs/installation/compatibility/#gke-autopilot

  ```
  57
  E0320 13:57:00.116379       1 leaderelection.go:336] error initially creating leader election record: leases.coordination.k8s.io is forbidden: User "system:serviceaccount:cert-manager:cert-manager" cannot create resource "leases" in API group "coordination.k8s.io" in the namespace "kube-system": GKE Warden authz [denied by managed-namespaces-limitation]: the namespace "kube-system" is managed and the request's verb "create" is denied
  ```

* CRDs installed:

  ```
  certificaterequests.cert-manager.io
  certificates.cert-manager.io
  challenges.acme.cert-manager.io
  clusterissuers.cert-manager.io
  issuers.cert-manager.io
  orders.acme.cert-manager.io
  ```

* Cert-manager `1.14+` looks for GA `1.0.0` gateway API CRDs:
  * https://github.com/cert-manager/cert-manager/issues/6649
  * https://github.com/kubernetes-sigs/gateway-api/releases

### External-secrets

https://external-secrets.io/latest/
https://artifacthub.io/packages/helm/external-secrets-operator/external-secrets

* CRDs installed:

  ```
  acraccesstokens.generators.external-secrets.io
  clusterexternalsecrets.external-secrets.io
  clustersecretstores.external-secrets.io
  ecrauthorizationtokens.generators.external-secrets.io
  externalsecrets.external-secrets.io
  fakes.generators.external-secrets.io
  gcraccesstokens.generators.external-secrets.io
  passwords.generators.external-secrets.io
  pushsecrets.external-secrets.io
  secretstores.external-secrets.io
  vaultdynamicsecrets.generators.external-secrets.io
  webhooks.generators.external-secrets.io
  ```


### Local development

You can use [minikube](https://minikube.sigs.k8s.io) to quickly start an all-in-one local Kubernetes cluster using Docker.

Sample [quickstart script](../scripts/k8s-local-dev.sh) to install CRDs used in this project.

### CD with native kubectl/helm

* Install Cert-manager

  ```bash
  helm repo add cert-manager https://charts.jetstack.io
  helm -n cert-manager install cert-manager cert-manager/cert-manager --version 1.14.7 \
  --values deploy/blockapt/manifests/dev/cert-manager.yaml --create-namespace --wait
  ```

* Create `ClusterIssuer` resources for Cert-manager (Let's Encrypt staging + production ACME)

  ```bash
  kubectl apply -f deploy/blockapt/values/dev/2-clusterissuers.yaml
  ```

* Install External Secrets

  ```bash
  helm repo add external-secrets https://charts.external-secrets.io
  helm -n external-secrets install external-secrets external-secrets/external-secrets --version 0.9.19 \
  --values deploy/blockapt/manifests/dev/external-secrets.yaml --create-namespace --wait
  ```

* Create `ClusterSecretStore` resource for External Secrets (Project's Google Secret Manager)

  ```bash
  kubectl apply -f deploy/blockapt/values/dev/2-clustersecretstore.yaml
  ```

* Install an application

  ```bash
  helm -n blockapt install app --values deploy/blockapt/values/dev/app.yaml --create-namespace --wait deploy/charts/blockapt/
  ```

* Create `Gateway` resources to expose all applications

  ```bash
  kubectl apply -f deploy/blockapt/manifests/dev/4-expose.yaml
  ```

* Install MongoDB

  ```bash
  helm repo add bitnami https://charts.bitnami.com/bitnami
  helm -n blockapt install mongodb bitnami/mongodb --version 15.6.9 \
  --values deploy/blockapt/manifests/dev/mongodb.yaml --create-namespace --wait
  ```
