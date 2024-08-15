# MongoDB deployment to Kubernetes

https://github.com/mongodb/mongo

## Bitnami's

Custom Helm chart + container image with bootstrap scripts (Debian 12 base)

#### Chart

* https://artifacthub.io/packages/helm/bitnami/mongodb
* https://github.com/bitnami/charts/tree/main/bitnami/mongodb

#### Container image

* https://hub.docker.com/r/bitnami/mongodb
* https://github.com/bitnami/containers/tree/main/bitnami/mongodb

### Quick install

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm -n blockapt install mongodb bitnami/mongodb --version 15.6.9 \
  --values deploy/blockapt/manifests/dev/mongodb.yaml --create-namespace --wait
```

## Community Kubernetes Operator

* https://github.com/mongodb/mongodb-kubernetes-operator
* https://github.com/mongodb/helm-charts/tree/main/charts/community-operator
* https://github.com/mongodb/helm-charts/tree/main/charts/community-operator-crds
* https://hub.docker.com/_/mongo
* https://quay.io/repository/mongodb/

Operator is installed into namespace `mongodb` and watches namespace `blockapt`:

* https://github.com/mongodb/mongodb-kubernetes-operator/blob/master/docs/install-upgrade.md#install-in-a-different-namespace-using-helm
* https://github.com/mongodb/mongodb-kubernetes-operator/issues/1500
* https://www.mongodb.com/docs/kubernetes-operator/master/tutorial/set-scope-k8s-operator/#std-label-ns-scope-different-ns

### Quick install

```bash
helm repo add mongodb https://mongodb.github.io/helm-charts
helm -n mongodb install community-operator mongodb/community-operator --version 0.9.0 \
  --values deploy/blockapt/manifests/dev/mongodb-operator.yaml --create-namespace --wait
```

RBAC resources for operator to watch/work in `blockapt` namespace:

```bash
helm -n blockapt template mongodb/community-operator --show-only templates/database_roles.yaml \
| kubectl apply -f -
```
