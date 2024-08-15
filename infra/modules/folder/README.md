<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Resources

| Name | Type |
|------|------|
| [google_folder.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/folder) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Folder display name | `string` | n/a | yes |
| <a name="input_parent"></a> [parent](#input\_parent) | Parent in folders/folder\_id or organizations/org\_id format | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | Folder display name. |
| <a name="output_folder_id"></a> [folder\_id](#output\_folder\_id) | Folder number |
| <a name="output_name"></a> [name](#output\_name) | Folder name in format folders/{folder\_id}. |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->