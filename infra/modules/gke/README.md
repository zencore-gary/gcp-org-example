## GKE clusters

* Workload identity
* Autoscaling
* Auto-repair + auto-upgrade
* Dynamic node pools, injected via variables
* Shielded VMs


https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool

<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Resources

| Name | Type |
|------|------|
| [google_container_cluster.cluster](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster) | resource |
| [google_container_node_pool.node_pools](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool) | resource |
| [google_project_iam_member.roles_artifactregistry_reader](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.roles_container_defaultnodeserviceaccount](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.roles_storage_objectviewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.cluster](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [random_id.postfix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Enable or Disable deletion protection on the cluster | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the cluster | `string` | `""` | no |
| <a name="input_enable_cost_allocation"></a> [enable\_cost\_allocation](#input\_enable\_cost\_allocation) | Enables Cost Allocation Feature and the cluster name and namespace of your GKE workloads appear in the labels field of the billing export to BigQuery | `bool` | `true` | no |
| <a name="input_ip_range_master"></a> [ip\_range\_master](#input\_ip\_range\_master) | IPv4 CIDR for the hosted master network | `string` | n/a | yes |
| <a name="input_ip_range_pods"></a> [ip\_range\_pods](#input\_ip\_range\_pods) | IPv4 CIDR for Kubernetes pods | `string` | n/a | yes |
| <a name="input_ip_range_services"></a> [ip\_range\_services](#input\_ip\_range\_services) | IPv4 CIDR for Kubernetes services | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | Required labels for GCE resources | `map(string)` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the cluster | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | (Required) The VPC Network to attach the cluster to | `string` | n/a | yes |
| <a name="input_network_project_id"></a> [network\_project\_id](#input\_network\_project\_id) | The project ID of the shared VPC's host (for shared vpc support) | `string` | `""` | no |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | List of maps containing node pools | `list(any)` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | (Required) The prefix e.g. dev/prod or blue/green | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | (Required) Project ID to provision the cluster | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to host the cluster in | `string` | `null` | no |
| <a name="input_regional"></a> [regional](#input\_regional) | Regional cluster (default is true) | `bool` | `true` | no |
| <a name="input_registry_project_ids"></a> [registry\_project\_ids](#input\_registry\_project\_ids) | Projects holding Google Container Registries. If empty, we use the cluster project. | `list(any)` | `[]` | no |
| <a name="input_release_channel"></a> [release\_channel](#input\_release\_channel) | GKE release channel: RAPID, REGULAR or STABLE | `string` | `"STABLE"` | no |
| <a name="input_stack_type"></a> [stack\_type](#input\_stack\_type) | The stack type to use for this cluster. Either `IPV4` or `IPV4_IPV6`. Defaults to `IPV4`. | `string` | `"IPV4"` | no |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | (Required) The subnetwork to host the cluster in | `string` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | The zones to host the cluster in (optional if regional cluster / required if zonal) | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_location"></a> [location](#output\_location) | GKE cluster location |
| <a name="output_name"></a> [name](#output\_name) | GKE cluster name |
| <a name="output_node_pools"></a> [node\_pools](#output\_node\_pools) | GKE cluster node pools |
| <a name="output_regional"></a> [regional](#output\_regional) | GKE cluster is regional with multiple masters spread across zones in the region |
| <a name="output_sa"></a> [sa](#output\_sa) | GKE cluster service account |
| <a name="output_zonal"></a> [zonal](#output\_zonal) | GKE cluster is zonal with a single master |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
