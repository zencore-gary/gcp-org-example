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
| <a name="module_cloudbuild"></a> [cloudbuild](#module\_cloudbuild) | ../../modules/cloudbuild | n/a |
| <a name="module_network"></a> [network](#module\_network) | ../../modules/network/vpc | n/a |
| <a name="module_project"></a> [project](#module\_project) | ../../modules/project | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | GCP - Billing account ID | `string` | n/a | yes |
| <a name="input_default_region"></a> [default\_region](#input\_default\_region) | GCP - Default region for all resources | `string` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | Top domain e.g. mydomain.com | `string` | n/a | yes |
| <a name="input_parent_folder"></a> [parent\_folder](#input\_parent\_folder) | GCP - Parent folder number | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for all resource names | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | GCP - DNS zone name |
| <a name="output_dns_name_servers"></a> [dns\_name\_servers](#output\_dns\_name\_servers) | GCP - DNS name servers |
| <a name="output_dns_zone"></a> [dns\_zone](#output\_dns\_zone) | GCP - DNS name |
| <a name="output_docker_registry"></a> [docker\_registry](#output\_docker\_registry) | Docker registry URL |
| <a name="output_shared_project"></a> [shared\_project](#output\_shared\_project) | GCP - Shared project ID |
| <a name="output_tf_state_bucket"></a> [tf\_state\_bucket](#output\_tf\_state\_bucket) | Terraform state bucket name |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
