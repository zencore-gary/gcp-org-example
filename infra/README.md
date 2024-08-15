# Infrastructure as code (IaC)

* [Terraform](https://github.com/hashicorp/terraform/)
* [TFLint](https://github.com/terraform-linters/tflint)
* [Terraform Provider for Google Cloud Platform](https://github.com/hashicorp/terraform-provider-google)

## Common Terraform files

* Linter configuration: `infra/.tflint.hcl`
* Makefile: `infra/Makefile`
* Terraform and plugins lock: `infra/versions.tf`

#### Created soft links in all environments

```bash
ln -s ../../.tflint.hcl .tflint.hcl
ln -s ../../Makefile Makefile
ln -s ../../versions.tf versions.tf
```

## Deployment order

1. `org`
1. `shared` => creates a bucket for Terraform states
1. Start using the bucket in backend configurations (move Terraform state from `1.` and `2.` into it)
1. `dev`, `prod`, `marketplace`, etc.

## Updating README files

Terraform-docs helps automate the documentation: the input variables, modules used, and outputs. The configuration for the output is in:
- [.terraform-docs-env.yml](./.terraform-docs-env.yml) for the Readmes in environments
- [.terraform-docs-modules.yml](./.terraform-docs-modules.yml) for the Readmes in modules

Run it from the root of the repo:

```
# To update an environment README
terraform-docs -c .terraform-docs-env.yml ./environments/<name>/
```

```
# To update a module README
terraform-docs -c .terraform-docs-modules.yml ./modules/<name>/
```

If it is a **new readme**, make sure to write up the description, usage examples, and include these lines at the bottom:

```
<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
```

This indicates to `terraform-docs` where to put the generated content.
