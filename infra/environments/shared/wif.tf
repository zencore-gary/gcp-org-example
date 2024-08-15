# TODO - Workload Identity Federation configuration with BitBucket

/*
module "workload_identity_federation" {
  source = "../../modules/wif-github"

  project_id           = module.project.project_id
  project_number       = module.project.project_number
  name                 = var.wif.pool_name
  github_provider_name = var.wif.github_provider_name
  github_organization  = var.wif.github_organization
  service_accounts     = var.wif.service_accounts

  depends_on = [module.project]
}

locals {
  terraform_sa_folder_roles = [
    # Roles to manage folders and projects
    "resourcemanager.folderAdmin",
    "resourcemanager.projectCreator",
    "resourcemanager.projectDeleter",
    "resourcemanager.projectMover",
    "serviceusage.serviceUsageAdmin",
    # General resources management
    "iam.securityAdmin",
    "iam.workloadIdentityPoolAdmin",
    "logging.admin",
    "monitoring.admin",
    # Roles to manage specific services that are in use
    "compute.admin",
    "compute.networkAdmin",
    "container.admin",
    "artifactregistry.admin",
    "dns.admin",
    "storage.admin",
    "pubsub.admin",
    "secretmanager.admin",
    "certificatemanager.owner",
  ]

  terraform_sa_billing_roles = [
    "billing.user",
    "billing.costsManager",
  ]

  github_sa_roles = [
    "artifactregistry.createOnPushRepoAdmin",
  ]
}

# Roles for the Terraform SA to manage cloud resources in the top folder
resource "google_folder_iam_member" "tf_sa_perms" {
  for_each = toset(local.terraform_sa_folder_roles)
  #checkov:skip=CKV_GCP_44:These are role assignments for the Terraform deployer SA
  #checkov:skip=CKV_GCP_45:These are role assignments for the Terraform deployer SA

  folder = var.go_folder
  role   = "roles/${each.value}"
  member = module.workload_identity_federation.service_accounts["terraform-sa"].member
}

# Roles for the Terraform SA to attach projects to the billing account
resource "google_billing_account_iam_member" "tf_sa_perms" {
  for_each           = toset(local.terraform_sa_billing_roles)
  billing_account_id = var.billing_account
  role               = "roles/${each.value}"
  member             = module.workload_identity_federation.service_accounts["terraform-sa"].member
}

# Roles for the Github deployer SA on the top folder
resource "google_folder_iam_member" "github_sa_perms" {
  for_each = toset(local.github_sa_roles)
  #checkov:skip=CKV_GCP_45:These are role assignments for the Terraform deployer SA

  folder = var.go_folder
  role   = "roles/${each.value}"
  member = module.workload_identity_federation.service_accounts["github-actions-build"].member
}
*/
