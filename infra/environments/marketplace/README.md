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
| <a name="provider_google"></a> [google](#provider\_google) | ~> 5.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion"></a> [bastion](#module\_bastion) | ../../modules/bastion | n/a |
| <a name="module_cloudnat"></a> [cloudnat](#module\_cloudnat) | ../../modules/network/cloudnat | n/a |
| <a name="module_cluster"></a> [cluster](#module\_cluster) | ../../modules/gke-autopilot | n/a |
| <a name="module_iap"></a> [iap](#module\_iap) | ../../modules/iap | n/a |
| <a name="module_network"></a> [network](#module\_network) | ../../modules/network/vpc | n/a |
| <a name="module_project"></a> [project](#module\_project) | ../../modules/project | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | GCP - Billing account ID | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | n/a | yes |
| <a name="input_parent_domain"></a> [parent\_domain](#input\_parent\_domain) | Parent Domain e.g.  mydomain.com | `string` | n/a | yes |
| <a name="input_parent_folder"></a> [parent\_folder](#input\_parent\_folder) | GCP - Parent project folder path | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for all resource names | `string` | n/a | yes |
| <a name="input_regions"></a> [regions](#input\_regions) | GCP - Region(s) for all resources | `list(any)` | n/a | yes |
| <a name="input_shared_project_id"></a> [shared\_project\_id](#input\_shared\_project\_id) | GCP - Shared project ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_debug"></a> [debug](#output\_debug) | n/a |
| <a name="output_marketplace_project"></a> [marketplace\_project](#output\_marketplace\_project) | GCP - Marketplace project ID |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Public IP for GKE Gateway |
| <a name="output_public_ip_name"></a> [public\_ip\_name](#output\_public\_ip\_name) | Value for key spec.addresses[0].value in Kubernetes Gateway |
| <a name="output_sa_annotation_cert_manager"></a> [sa\_annotation\_cert\_manager](#output\_sa\_annotation\_cert\_manager) | cert-manager - Kubernetes service account annotation to use Google Service Account |
| <a name="output_sa_annotation_external_secrets"></a> [sa\_annotation\_external\_secrets](#output\_sa\_annotation\_external\_secrets) | External Secrets - Kubernetes service account annotation to use Google Service Account |
| <a name="output_sa_annotation_marketplace"></a> [sa\_annotation\_marketplace](#output\_sa\_annotation\_marketplace) | Marketplace backend integration - Kubernetes service account annotation to use Google Service Account |
| <a name="output_security_policy_name"></a> [security\_policy\_name](#output\_security\_policy\_name) | Value for key spec.default.securityPolicy in Kubernetes GCPBackendPolicy |
| <a name="output_test_topic"></a> [test\_topic](#output\_test\_topic) | GCP - Test topic name |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
