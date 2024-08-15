<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Resources

| Name | Type |
|------|------|
| [google_cloudbuild_worker_pool.pool](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuild_worker_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Machine type for Cloud Build worker pool | `string` | `"e2-medium"` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the cluster | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | (Required) The prefix e.g. dev/prod or blue/green | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | (Required) Project ID to provision the cluster | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | (Required) The Region the instance should be provisioned in | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
