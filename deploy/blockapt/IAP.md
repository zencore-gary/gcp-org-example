# Google IAP

## Configure the `OAuth consent screen`

Global defaults for to the whole project. The application is internal by default,
only users who belong to your organization will be allowed to login.

https://console.cloud.google.com/apis/credentials/consent

* **App name**: `<app>-<env>`
* **User support email**: `ddumas@zencore.dev`
* **Authorized domain 1**: `zencore.dev`
* **Email addresses**: `ddumas@zencore.dev`
* **App domain**: Leave empty

No need for scopes (at least just for this Gateway + IAP).

## Create Oauth 2.0 Client ID

https://console.cloud.google.com/apis/credentials

* At the top click on `[ + CREATE CREDENTIALS ]` then pick `[ OAuth Client ID ]`
* Application type => select `Web application`
* Name => enter `<app>-<en>-argo`
* Get the `Client ID` and `Client secret` and store them in the project Google Secret Manager
as `ARGO_IAP_CLIENT_ID` and `ARGO_IAP_CLIENT_SECRET`
* Add this to "Authorized redirect URIs": `https://iap.googleapis.com/v1/oauth/clientIds/<client_id>:handleRedirect`

For the `GCPBackendPolicy` resource and enabling IAP on the Kubernetes side, you need to create
a `Secret` with name `argocd-iap` and store the `Client secret` value in key named `key`.

* Manually:

```bash
# From a file:
kubectl -n argo create secret generic argocd-iap --from-file=key=iap-secret.txt
# From a string:
secret='xxxxxx-xxxxxxxxxxxxxxxxxxxxxxx-xxxx'
eval "kubectl -n argo create secret generic argocd-iap --from-literal=key='${secret}'"
```

* Using External Secrets to fetch it from Google Secret Manager:

```yaml
---
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: argocd-iap
  namespace: argo
spec:
  refreshInterval: 1h
  secretStoreRef:
    kind: ClusterSecretStore
    name: <cluster_secret_store_name>
  target:
    name: argocd-iap
  data:
  - secretKey: key
    remoteRef:
      key: ARGO_IAP_CLIENT_SECRET
```
