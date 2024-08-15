<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 5.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | ~> 5.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.37.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion"></a> [bastion](#module\_bastion) | ../../modules/bastion | n/a |
| <a name="module_cloudnat"></a> [cloudnat](#module\_cloudnat) | ../../modules/network/cloudnat | n/a |
| <a name="module_cloudsql"></a> [cloudsql](#module\_cloudsql) | ../../modules/cloudsql | n/a |
| <a name="module_cluster"></a> [cluster](#module\_cluster) | ../../modules/gke | n/a |
| <a name="module_mysql_iam_users"></a> [mysql\_iam\_users](#module\_mysql\_iam\_users) | ../../modules/cloudsql-iam-users | n/a |
| <a name="module_network"></a> [network](#module\_network) | ../../modules/network/vpc | n/a |
| <a name="module_project"></a> [project](#module\_project) | ../../modules/project | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | GCP - Billing account ID | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | n/a | yes |
| <a name="input_parent_domain"></a> [parent\_domain](#input\_parent\_domain) | Parent domain e.g. mydomain.com | `string` | n/a | yes |
| <a name="input_parent_folder"></a> [parent\_folder](#input\_parent\_folder) | GCP - Parent project folder path | `string` | n/a | yes |
| <a name="input_parent_zone"></a> [parent\_zone](#input\_parent\_zone) | Parent GCP zone name | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for all resource names | `string` | n/a | yes |
| <a name="input_regions"></a> [regions](#input\_regions) | GCP - Region(s) for all resources | `list(any)` | n/a | yes |
| <a name="input_shared_project_id"></a> [shared\_project\_id](#input\_shared\_project\_id) | GCP - Shared project ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion"></a> [bastion](#output\_bastion) | Bastion |
| <a name="output_cloud_sql_admins"></a> [cloud\_sql\_admins](#output\_cloud\_sql\_admins) | CloudSQL proxy - Admin username |
| <a name="output_cloud_sql_proxy_connection_names"></a> [cloud\_sql\_proxy\_connection\_names](#output\_cloud\_sql\_proxy\_connection\_names) | CloudSQL proxy - Instance connection name |
| <a name="output_cloud_sql_users"></a> [cloud\_sql\_users](#output\_cloud\_sql\_users) | CloudSQL proxy - Admin username |
| <a name="output_cluster"></a> [cluster](#output\_cluster) | GKE |
| <a name="output_project"></a> [project](#output\_project) | Project ID |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Public IP for Gateway |
| <a name="output_public_ip_name"></a> [public\_ip\_name](#output\_public\_ip\_name) | Value for key spec.addresses[0].value in Kubernetes Gateway |
| <a name="output_sa_annotation_cert_manager"></a> [sa\_annotation\_cert\_manager](#output\_sa\_annotation\_cert\_manager) | cert-manager - Kubernetes SA annotation value to use Google Service Account |
| <a name="output_sa_annotation_external_secrets"></a> [sa\_annotation\_external\_secrets](#output\_sa\_annotation\_external\_secrets) | External Secrets - Kubernetes SA annotation value to use Google Service Account |
| <a name="output_sa_annotation_mysql_admins"></a> [sa\_annotation\_mysql\_admins](#output\_sa\_annotation\_mysql\_admins) | MySQL admin - Kubernetes SA annotation values to use Google Service Account |
| <a name="output_security_policy_name"></a> [security\_policy\_name](#output\_security\_policy\_name) | Value for key spec.default.securityPolicy in Kubernetes GCPBackendPolicy |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
