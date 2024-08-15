# Generic Helm chart for applications

---
## Parameters

### Common parameters

| Name                | Description                                                                                       | Value              |
| ------------------- | ------------------------------------------------------------------------------------------------- | ------------------ |
| `nameOverride`      | String to partially override `common.name` template (will maintain the release name)              | `""`               |
| `fullnameOverride`  | String to fully override `common.fullname` template                                               | `""`               |
| `replicaCount`      | Number of pods to deploy                                                                          | `1`                |
| `image.registry`    | Container image registry                                                                          | `path/to/registry` |
| `image.repository`  | Container image repository                                                                        | `app`              |
| `image.tag`         | Container image tag                                                                               | `""`               |
| `image.digest`      | Container image digest in the way `sha256:aa...`. If this parameter is set, overrides `image.tag` | `""`               |
| `image.pullPolicy`  | Container image pull policy. Allowed values: `Always`, `Never`, `IfNotPresent`                    | `IfNotPresent`     |
| `image.pullSecrets` | Specify container registry secret names as an array                                               | `[]`               |
| `commonLabels`      | Add labels to all deployed objects                                                                | `{}`               |
| `component`         | Component standard label value and container name                                                 | `app`              |
| `partOf`            | Part-of standard label value                                                                      | `product`          |
| `ports.http`        | Application container port (HTTP)                                                                 | `8080`             |
| `ports.metrics`     | Promotheus exporter container port (HTTP)                                                         | `8081`             |

### Deployment configuration

| Name                                               | Description                                                                                                                                          | Value                                                         |
| -------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------- |
| `environment`                                      | Container environment variables                                                                                                                      | `{}`                                                          |
| `configMap.data`                                   | Custom ConfigMap data                                                                                                                                | `""`                                                          |
| `configMap.mountPath`                              | Custom ConfigMap mount path                                                                                                                          | `/etc/app`                                                    |
| `externalEnvironmentSecrets`                       | Container secret environment variables pulled from Google Secret Manager (GCPSM) using external-secrets                                              |                                                               |
| `externalEnvironmentSecrets.refreshInterval`       | Used to configure store refresh interval in seconds, empty or 0 will default to the controller config                                                | `0`                                                           |
| `externalEnvironmentSecrets.secretStoreRef.kind`   | Allowed values: `SecretStore` or `ClusterSecretStore`                                                                                                | `ClusterSecretStore`                                          |
| `externalEnvironmentSecrets.secretStoreRef.name`   | Secret store to use when fetching the secret data                                                                                                    | `""`                                                          |
| `externalEnvironmentSecrets.target`                | Extra target options to describe how the secret shall be created                                                                                     | `{}`                                                          |
| `externalEnvironmentSecrets.secretKeys`            | GCPSM secrets, mapped 1:1 as environment variables                                                                                                   | `[]`                                                          |
| `externalEnvironmentSecrets.prefix`                | GCPSM secrets prefix, stripped (optional)                                                                                                            | `""`                                                          |
| `deployment.annotations`                           | Deployment extra annotations                                                                                                                         | `{}`                                                          |
| `deployment.labels`                                | Deployment extra labels                                                                                                                              | `{}`                                                          |
| `deployment.strategy`                              | Deployment strategy                                                                                                                                  | `{}`                                                          |
| `pod.annotations`                                  | Extra annotations for Deployment pods                                                                                                                | `{}`                                                          |
| `pod.labels`                                       | Extra labels for Deployment pods                                                                                                                     | `{}`                                                          |
| `pod.securityContext.enabled`                      | Enable pods Security Context                                                                                                                         | `true`                                                        |
| `pod.securityContext.fsGroup`                      | Special supplemental GID that applies to all containers in a pod                                                                                     | `65532`                                                       |
| `pod.securityContext.fsGroupChangePolicy`          | Defines behavior of changing ownership and permission of the volume before being exposed inside pods. Valid values are `OnRootMismatch` and `Always` | `Always`                                                      |
| `pod.securityContext.sysctls`                      | List of namespaced sysctls used for the pod                                                                                                          | `[]`                                                          |
| `pod.extraVolumes`                                 | Specify extra list of additional volumes for pod                                                                                                     | `[]`                                                          |
| `pod.affinity`                                     | Affinity for pods assignment                                                                                                                         | `{}`                                                          |
| `pod.nodeSelector`                                 | Node labels for pods assignment                                                                                                                      | `{}`                                                          |
| `pod.tolerations`                                  | Tolerations for pods assignment                                                                                                                      | `[]`                                                          |
| `pod.terminationGracePeriodSeconds`                | Duration in seconds the pod needs to terminate gracefully                                                                                            | `30`                                                          |
| `container.command`                                | Entrypoint array                                                                                                                                     | `[]`                                                          |
| `container.args`                                   | Arguments to the entrypoint array                                                                                                                    | `[]`                                                          |
| `container.env`                                    | List of environment variables to set in the container                                                                                                | `[]`                                                          |
| `container.resources`                              | Resources requests/limits for container                                                                                                              | `{}`                                                          |
| `container.extraVolumeMounts`                      | Specify extra list of additional volumeMounts for container                                                                                          | `[]`                                                          |
| `container.securityContext.enabled`                | Enable containers Security Context                                                                                                                   | `true`                                                        |
| `container.securityContext.readOnlyRootFilesystem` | Whether this container has a read-only root filesystem                                                                                               | `true`                                                        |
| `container.securityContext.runAsGroup`             | The GID to run the entrypoint of the container process                                                                                               | `65532`                                                       |
| `container.securityContext.runAsNonRoot`           | Indicates that the container must run as a non-root user                                                                                             | `true`                                                        |
| `container.securityContext.runAsUser`              | The UID to run the entrypoint of the container process                                                                                               | `65532`                                                       |
| `container.livenessProbe`                          | Override default liveness probe                                                                                                                      | `{}`                                                          |
| `container.readinessProbe`                         | Override default readiness probe                                                                                                                     | `{}`                                                          |
| `container.startupProbe`                           | Add custom startup probe                                                                                                                             | `{}`                                                          |
| `cloudSqlProxy.enabled`                            | Enable Google Cloud SQL Proxy sidecar                                                                                                                | `false`                                                       |
| `cloudSqlProxy.image`                              | Cloud SQL Proxy container image                                                                                                                      | `gcr.io/cloud-sql-connectors/cloud-sql-proxy:2.11.4-bullseye` |
| `cloudSqlProxy.ports.proxy`                        | Port for Cloud SQL Proxy                                                                                                                             | `3306`                                                        |
| `cloudSqlProxy.ports.http`                         | Port for Prometheus and health check server                                                                                                          | `9090`                                                        |
| `cloudSqlProxy.instanceConnectionName`             | Instance Connection Name                                                                                                                             | `project:region:instance`                                     |
| `cloudSqlProxy.privateIP`                          | Connect to the private IP address for all instances                                                                                                  | `true`                                                        |
| `cloudSqlProxy.IAM`                                | Enable passwordless IAM authentication for all instances                                                                                             | `true`                                                        |
| `cloudSqlProxy.debug`                              | Enable pprof on the localhost admin server                                                                                                           | `false`                                                       |
| `cloudSqlProxy.debugLogs`                          | Enable debug logging                                                                                                                                 | `false`                                                       |
| `cloudSqlProxy.healthCheck`                        | Enables endpoints /startup, /liveness and /readiness and probes                                                                                      | `true`                                                        |
| `cloudSqlProxy.resources`                          | Resources requests/limits for container                                                                                                              | `{}`                                                          |

### Service configuration

| Name                    | Description                                                                                                                                    | Value       |
| ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| `service.enabled`       | Enable service to container ports                                                                                                              | `true`      |
| `service.type`          | Service type. Allowed values: `ExternalName`, `ClusterIP`, `NodePort`, `LoadBalance`                                                           | `ClusterIP` |
| `service.annotations`   | Service extra annotations                                                                                                                      | `{}`        |
| `service.neg`           | Add Google Network Endpoint Group (NEG) annotation to service port number with an automatically generated name (used by Gateways + HTTPRoutes) | `true`      |
| `service.labels`        | Service extra labels                                                                                                                           | `{}`        |
| `service.ports.http`    | Application service port (HTTP)                                                                                                                | `8080`      |
| `service.ports.metrics` | Promotheus exporter service port (HTTP)                                                                                                        | `8081`      |

### Service Account and RBAC configuration

| Name                                          | Description                                                                                                         | Value   |
| --------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | ------- |
| `serviceAccount.create`                       | Enable creation of a Service Account for pod(s)                                                                     | `true`  |
| `serviceAccount.annotations`                  | Service Account extra annotations                                                                                   | `{}`    |
| `serviceAccount.annotations`                  | Service Account extra annotations                                                                                   | `{}`    |
| `serviceAccount.labels`                       | Service Account extra labels                                                                                        | `{}`    |
| `serviceAccount.automountServiceAccountToken` | API token automatically mounted into pods using this Service Account. Set to `false` if pods do not use the K8s API | `false` |
| `serviceAccount.enforceMountableSecrets`      | Secrets can only be mounted on specified types of resources, enhancing the security                                 | `true`  |
| `serviceAccount.extraSecrets`                 | List of extra secrets allowed to be mounted by pods using this Service Account                                      | `[]`    |
| `rbac.create`                                 | Specifies whether RBAC resources should be created                                                                  | `false` |
| `rbac.rules`                                  | Custom RBAC rules to set                                                                                            | `[]`    |

### Ingress configuration

| Name                  | Description                                                                                                        | Value    |
| --------------------- | ------------------------------------------------------------------------------------------------------------------ | -------- |
| `ingress.enabled`     | Enable ingress to service port `http` (HTTP)                                                                       | `false`  |
| `ingress.annotations` | Ingress extra annotations                                                                                          | `{}`     |
| `ingress.labels`      | Ingress extra labels                                                                                               | `{}`     |
| `ingress.className`   | Set `ingressClassName` on the ingress record                                                                       | `""`     |
| `ingress.host`        | Fully qualified domain name of a network host                                                                      | `""`     |
| `ingress.path`        | Path to application                                                                                                | `/`      |
| `ingress.pathType`    | Determines the interpretation of the `Path` matching.  Allowed values: `Exact`, `Prefix`, `ImplementationSpecific` | `Prefix` |
| `ingress.tls`         | Enable TLS configuration for `hostname`                                                                            | `[]`     |

### Gateway configuration

| Name                  | Description                                  | Value   |
| --------------------- | -------------------------------------------- | ------- |
| `gateway.enabled`     | Enable Gateway to service port `http` (HTTP) | `false` |
| `gateway.annotations` | Gateway extra annotations                    | `{}`    |
| `gateway.labels`      | Gateway extra labels                         | `{}`    |
| `gateway.className`   | Set `gatewayClassName` on the Gateway record | `""`    |
| `gateway.addresses`   | Addresses requested for this Gateway         | `[]`    |
| `gateway.listeners`   | Listeners associated with this Gateway       | `[]`    |

### Network Policy configuration

| Name                                              | Description                                                         | Value   |
| ------------------------------------------------- | ------------------------------------------------------------------- | ------- |
| `networkPolicy.enabled`                           | Enable predefined Network Policies                                  | `false` |
| `networkPolicy.labels`                            | Network Policies extra labels                                       | `{}`    |
| `networkPolicy.allowExternalEgress`               | Allow pods to access any range of port and all destinations         | `true`  |
| `networkPolicy.allowGoogleCloudProbers`           | Allow Google Cloud probers (Load balancer health checks)            | `true`  |
| `networkPolicy.allowGoogleCloudManagedCollection` | Allow Google Cloud Managed Collection (Prometheus metrics scraping) | `true`  |
| `networkPolicy.extraIngress`                      | Add extra ingress rules to the NetworkPolicy                        | `[]`    |
| `networkPolicy.extraEgress`                       | Add extra egress rules to the NetworkPolicy                         | `[]`    |

### Monitoring configuration

| Name                                              | Description                                                                        | Value   |
| ------------------------------------------------- | ---------------------------------------------------------------------------------- | ------- |
| `metrics.enabled`                                 | Enable Prometheus metrics endpoint                                                 | `false` |
| `metrics.podMonitoring.enabled`                   | Creates a Prometheus Operator PodMonitor (requires `metrics.enabled` to be `true`) | `false` |
| `metrics.podMonitoring.endpoint`                  | The endpoint to scrape on the selected pods (`metrics` port)                       |         |
| `metrics.podMonitoring.endpoint.interval`         | Interval at which to scrape metrics                                                | `""`    |
| `metrics.podMonitoring.endpoint.metricRelabeling` | Relabeling rules for metrics scraped from this endpoint                            | `[]`    |
| `metrics.podMonitoring.endpoint.timeout`          | Timeout for metrics scrapes                                                        | `""`    |
| `metrics.podMonitoring.limits`                    | Limits to apply at scrape time                                                     | `{}`    |
| `metrics.podMonitoring.targetLabels`              | Labels to add to the Prometheus target for discovered endpoints                    | `{}`    |
