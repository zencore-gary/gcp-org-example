<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Resources

| Name | Type |
|------|------|
| [google_iap_web_iam_member.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iap_web_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_host"></a> [host](#input\_host) | Filter specific host (scope IAP access) | `string` | n/a | yes |
| <a name="input_iap_members"></a> [iap\_members](#input\_iap\_members) | Custom IAP authorized members | `list(string)` | `[]` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | (Required) Project ID to provision the cluster | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->