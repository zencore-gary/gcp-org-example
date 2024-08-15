<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_instance.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_project_iam_member.roles_container_clusteradmin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.roles_container_containeradmin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.roles_logswriter](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.roles_metricswriter](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.bastion](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [random_shuffle.google_compute_zone](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/shuffle) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the instance | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | (Required) The VPC Network to attach the instance to | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | (Required) The prefix e.g. dev/prod or blue/green | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | (Required) Project ID to provision the instance | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | (Required) The region the instance should be provisioned in | `string` | n/a | yes |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | (Required) The subnetwork to host the instance in | `string` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | (Required) Instance type | `string` | `"e2-micro"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name"></a> [name](#output\_name) | VM instance name |
| <a name="output_region"></a> [region](#output\_region) | VM instance region |
| <a name="output_sa"></a> [sa](#output\_sa) | VM instance service account |
| <a name="output_zone"></a> [zone](#output\_zone) | VM instance zone |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
