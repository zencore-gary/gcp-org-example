<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_container_cluster.cluster](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_container_cluster) | resource |
| [google_project_iam_member.roles_artifactregistry_reader](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.roles_container_defaultnodeserviceaccount](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.roles_storage_objectviewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.cluster](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [random_id.postfix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_shuffle.available_zones](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/shuffle) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autopilot"></a> [autopilot](#input\_autopilot) | Enable autopilot mode (default is false) | `bool` | `false` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Enable or Disable deletion protection on the cluster | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the cluster | `string` | `""` | no |
| <a name="input_enable_cost_allocation"></a> [enable\_cost\_allocation](#input\_enable\_cost\_allocation) | Enables Cost Allocation Feature and the cluster name and namespace of your GKE workloads appear in the labels field of the billing export to BigQuery | `bool` | `false` | no |
| <a name="input_ip_range_pods"></a> [ip\_range\_pods](#input\_ip\_range\_pods) | IPv4 CIDR for Kubernetes pods | `string` | n/a | yes |
| <a name="input_ip_range_services"></a> [ip\_range\_services](#input\_ip\_range\_services) | IPv4 CIDR for Kubernetes services | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | Required labels for resources | <pre>object({<br>    env     = string<br>    purpose = string<br>    owner   = string<br>  })</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the cluster | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | (Required) The VPC Network to attach the cluster to | `string` | n/a | yes |
| <a name="input_network_project_id"></a> [network\_project\_id](#input\_network\_project\_id) | The project ID of the shared VPC's host (for shared vpc support) | `string` | `""` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | (Required) The prefix e.g. dev/prod or blue/green | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | (Required) Project ID to provision the cluster | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to host the cluster in | `string` | `null` | no |
| <a name="input_regional"></a> [regional](#input\_regional) | Regional cluster (default is true) | `bool` | `true` | no |
| <a name="input_registry_project_ids"></a> [registry\_project\_ids](#input\_registry\_project\_ids) | Projects holding Google Container Registries. If empty, we use the cluster project. | `list(any)` | `[]` | no |
| <a name="input_release_channel"></a> [release\_channel](#input\_release\_channel) | GKE Release channel. | `string` | `"REGULAR"` | no |
| <a name="input_stack_type"></a> [stack\_type](#input\_stack\_type) | The stack type to use for this cluster. Either `IPV4` or `IPV4_IPV6`. Defaults to `IPV4`. | `string` | `"IPV4"` | no |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | (Required) The subnetwork to host the cluster in | `string` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | The zones to host the cluster in (optional if regional cluster / required if zonal) | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name"></a> [name](#output\_name) | GKE cluster name |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
