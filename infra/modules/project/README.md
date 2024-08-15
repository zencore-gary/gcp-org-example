<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_project_metadata_item.osconfig](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_project_metadata_item) | resource |
| [google_compute_project_metadata_item.oslogin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_project_metadata_item) | resource |
| [google_essential_contacts_contact.contacts](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/essential_contacts_contact) | resource |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project) | resource |
| [google_project_default_service_accounts.default_compute_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_default_service_accounts) | resource |
| [google_project_iam_member.iam](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.default_services](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.services](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.managed_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [random_id.project_id_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_create_network"></a> [auto\_create\_network](#input\_auto\_create\_network) | Controls whether the 'default' network exists on the project. Defaults set to false, the default network will still be created by GCP but will be deleted immediately by Terraform. | `bool` | `false` | no |
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | billing account id | `string` | n/a | yes |
| <a name="input_create_managed_service_account"></a> [create\_managed\_service\_account](#input\_create\_managed\_service\_account) | Create a service account for the project. | `bool` | `false` | no |
| <a name="input_disable_default_service_account"></a> [disable\_default\_service\_account](#input\_disable\_default\_service\_account) | The default service account behavior. | `bool` | `false` | no |
| <a name="input_disable_dependent_services"></a> [disable\_dependent\_services](#input\_disable\_dependent\_services) | Disable dependent services when disabling a service. | `bool` | `true` | no |
| <a name="input_disable_service_on_destroy"></a> [disable\_service\_on\_destroy](#input\_disable\_service\_on\_destroy) | Disable services when destroying the project. | `bool` | `true` | no |
| <a name="input_essential_contacts"></a> [essential\_contacts](#input\_essential\_contacts) | List of essential contacts (by email) | `list(string)` | `[]` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | parent folder id | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Resource labels required for deployment. | <pre>object({<br>    env     = string<br>    purpose = string<br>    owner   = string<br>  })</pre> | n/a | yes |
| <a name="input_managed_sa_roles"></a> [managed\_sa\_roles](#input\_managed\_sa\_roles) | The roles to assign to the service account. | `list(string)` | `[]` | no |
| <a name="input_managed_service_account_id"></a> [managed\_service\_account\_id](#input\_managed\_service\_account\_id) | The service account to create. | `string` | `"tf-managed-sa"` | no |
| <a name="input_name"></a> [name](#input\_name) | project display name | `string` | n/a | yes |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | The organization id | `string` | `null` | no |
| <a name="input_oslogin"></a> [oslogin](#input\_oslogin) | Enable OSLogin | `string` | `"TRUE"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID | `string` | `null` | no |
| <a name="input_services"></a> [services](#input\_services) | The list of services to enable on the project. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_enabled_services"></a> [enabled\_services](#output\_enabled\_services) | Enabled APIs. |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | Project ID. |
| <a name="output_project_number"></a> [project\_number](#output\_project\_number) | Project number. |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
