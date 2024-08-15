<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Resources

| Name | Type |
|------|------|
| [google_logging_folder_sink.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_folder_sink) | resource |
| [google_project_iam_member.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_id"></a> [bucket\_id](#input\_bucket\_id) | (Required) Target bucket ID | `string` | n/a | yes |
| <a name="input_exclusions"></a> [exclusions](#input\_exclusions) | (Optional) Folder logging sink exclusions concatenated with defaults | <pre>list(object({<br>    name        = string<br>    description = string<br>    filter      = string<br>  }))</pre> | `[]` | no |
| <a name="input_filter"></a> [filter](#input\_filter) | (Optional) Folder logging sink filter | `string` | `""` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | (Required) Target folder ID | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) Logging bucket location | `string` | `"global"` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Name for resources | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | (Required) Target project ID with the logging bucket | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->