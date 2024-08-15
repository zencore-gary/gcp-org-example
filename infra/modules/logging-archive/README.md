<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Resources

| Name | Type |
|------|------|
| [google_logging_folder_sink.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_folder_sink) | resource |
| [google_storage_bucket.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_member.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_exclusions"></a> [exclusions](#input\_exclusions) | (Optional) Folder logging sink exclusions (concatenated with defaults) | <pre>list(object({<br>    name        = string<br>    description = string<br>    filter      = string<br>  }))</pre> | `[]` | no |
| <a name="input_expiration_days"></a> [expiration\_days](#input\_expiration\_days) | (Required) Logging expiration in days | `number` | `1096` | no |
| <a name="input_filter"></a> [filter](#input\_filter) | (Optional) Folder logging sink filter | `string` | `""` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | (Required) Folder ID to provision the logging | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | (Optional) A map of key/value label pairs to assign to the bucket | `map(any)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | (Optional) Logging bucket location | `string` | `"EU"` | no |
| <a name="input_lock"></a> [lock](#input\_lock) | (Optional) Lock storage bucket | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Name for resources | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | (Required) Project ID to provision the logging | `string` | n/a | yes |
| <a name="input_retention_days"></a> [retention\_days](#input\_retention\_days) | (Required) Logging retention in days | `number` | `1095` | no |

## Outputs

No outputs.
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->