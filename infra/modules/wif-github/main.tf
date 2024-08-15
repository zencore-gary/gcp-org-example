# Create workload identity pool

resource "google_iam_workload_identity_pool" "this" {
  project                   = var.project_id
  workload_identity_pool_id = var.name
  display_name              = var.display_name != null ? var.display_name : var.name
  description               = var.description
}

# Create the workload identity pool provider for Github

resource "google_iam_workload_identity_pool_provider" "this" {
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.pool.workload_identity_pool_id
  workload_identity_pool_provider_id = var.github_provider_name
  attribute_mapping = {
    "google.subject"             = "assertion.sub",
    "attribute.actor"            = "assertion.actor",
    "attribute.aud"              = "assertion.aud",
    "attribute.repository_owner" = "assertion.repository_owner",
    "attribute.sub"              = "assertion.sub"
    "attribute.repository"       = "assertion.repository"
    "attribute.ref"              = "assertion.ref"
  }
  attribute_condition = "assertion.repository_owner==\"${var.github_organization}\""
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

# Create the service accounts to be used with workload identity federation

resource "google_service_account" "this" {
  for_each = var.service_accounts

  project      = var.project_id
  account_id   = each.key
  display_name = each.value.display_name != null ? each.value.display_name : each.key
  description  = "${each.key} SA for Workload Identity (managed by Terraform)"
}

# Allow workload identity provider to impersonate the service account

resource "google_service_account_iam_member" "this" {
  for_each = var.service_accounts

  service_account_id = google_service_account.sa[each.key].id
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/projects/${var.project_number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.pool.workload_identity_pool_id}/${each.value.github_condition != null ? each.value.github_condition : "*"}"
}
