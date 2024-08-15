<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_address.ext_ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_router.router](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_compute_router_nat.router_nat](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the cluster | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | (Required) The prefix e.g. dev/prod or blue/green | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | (Required) Project ID to provision the cluster | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | (Required) The subnetwork to deploy to | `map(any)` | n/a | yes |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | (Required) The VPC Network | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nat_ip"></a> [nat\_ip](#output\_nat\_ip) | NAT gateway IPs |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
