# Workload Identity Federation

This module configures Workload Identity Federation to be used with *GitHub Actions*.

It creates the following resources:

- **GCP Service Account**: this is the service account that will be used by GitHub Actions to authenticate to GCP.

- **Workload Identity Pool and Provider**: this is the pool and provider that will be used by the GCP Service Account to authenticate to GCP.

- **IAM Bindings**: this binds the GCP Service Account to the Workload Identity Pool and Provider.

For more information on Workload Identity Federation, see the [official documentation](https://cloud.google.com/iam/docs/workload-identity-federation).

<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Resources

| Name | Type |
|------|------|
| [google_iam_workload_identity_pool.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool) | resource |
| [google_iam_workload_identity_pool_provider.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider) | resource |
| [google_service_account.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description of the WIF pool | `string` | `""` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Display name of the WIF pool | `string` | `null` | no |
| <a name="input_github_organization"></a> [github\_organization](#input\_github\_organization) | Name of the Github org - will be used on the WIF provider condition. | `string` | n/a | yes |
| <a name="input_github_provider_name"></a> [github\_provider\_name](#input\_github\_provider\_name) | Name for the Github WIF provider | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the WIF pool | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the GCP project | `string` | n/a | yes |
| <a name="input_project_number"></a> [project\_number](#input\_project\_number) | The number of the GCP project | `string` | n/a | yes |
| <a name="input_service_accounts"></a> [service\_accounts](#input\_service\_accounts) | The list of service accounts to set up with WIF. Map keys are the service account IDs. | <pre>map(object({<br>    display_name     = optional(string)<br>    github_condition = optional(string)<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_accounts"></a> [service\_accounts](#output\_service\_accounts) | Google Service Account(s) created |
| <a name="output_wif_pool_id"></a> [wif\_pool\_id](#output\_wif\_pool\_id) | Google IAM - Workload Identity - Pool ID |
| <a name="output_wif_provider_id"></a> [wif\_provider\_id](#output\_wif\_provider\_id) | Google IAM - Workload Identity - Pool ID (GitHub provider) |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
