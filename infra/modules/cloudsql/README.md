<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Resources

| Name | Type |
|------|------|
| [google_project_iam_member.cloudsql_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.iam_wiu](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_secret_manager_secret.mysql_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_version.mysql_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_service_account.mysql_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_sql_database_instance.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |
| [google_sql_user.mysql_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |
| [random_id.db_name_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_password.mysql_admin](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_version"></a> [database\_version](#input\_database\_version) | (Optional) The database version to use | `string` | `"MYSQL_8_0"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Enforce deletion protection on the database instance (default false) | `bool` | `false` | no |
| <a name="input_extra_flags"></a> [extra\_flags](#input\_extra\_flags) | List of CloudSQL flags that are applied to the database server | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_general_logging"></a> [general\_logging](#input\_general\_logging) | View SQL queries executed on the database instance in logs | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the cluster | `string` | n/a | yes |
| <a name="input_path"></a> [path](#input\_path) | (Required) The Kubernetes resource path, format: <namespace>/<service\_account\_name> | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | (Required) The prefix e.g. dev/prod or blue/green | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | (Required) Project ID to provision the cluster | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | (Required) The Region the instance should be provisioned in | `string` | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | (Optional) The instance tier | `string` | `"db-f1-micro"` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | The VPC network to connect the instance to | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_email"></a> [admin\_email](#output\_admin\_email) | Admin username |
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | Admin password (stored in Google Cloud Secret Manager) |
| <a name="output_admin_username"></a> [admin\_username](#output\_admin\_username) | Admin username |
| <a name="output_connection_name"></a> [connection\_name](#output\_connection\_name) | Connection name - Format: <project>:<region>:<instance> |
| <a name="output_name"></a> [name](#output\_name) | Cloud SQL instance name |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
