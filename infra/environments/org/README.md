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
| <a name="module_dev_folder"></a> [dev\_folder](#module\_dev\_folder) | ../../modules/folder | n/a |
| <a name="module_dev_logging"></a> [dev\_logging](#module\_dev\_logging) | ../../modules/logging | n/a |
| <a name="module_logging_project"></a> [logging\_project](#module\_logging\_project) | ../../modules/project | n/a |
| <a name="module_marketplace_folder"></a> [marketplace\_folder](#module\_marketplace\_folder) | ../../modules/folder | n/a |
| <a name="module_shared_folder"></a> [shared\_folder](#module\_shared\_folder) | ../../modules/folder | n/a |
| <a name="module_shared_logging"></a> [shared\_logging](#module\_shared\_logging) | ../../modules/logging | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | GCP - Billing account ID | `string` | n/a | yes |
| <a name="input_log_location"></a> [log\_location](#input\_log\_location) | Location for the Log Bucket | `string` | n/a | yes |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | (Optional) Logging retention in days | `number` | `365` | no |
| <a name="input_parent_folder"></a> [parent\_folder](#input\_parent\_folder) | GCP - Parent project folder path | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for all resource names | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dev_folder"></a> [dev\_folder](#output\_dev\_folder) | dev folder number |
| <a name="output_marketplace_folder"></a> [marketplace\_folder](#output\_marketplace\_folder) | marketplace folder number |
| <a name="output_shared_folder"></a> [shared\_folder](#output\_shared\_folder) | shared folder number |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
