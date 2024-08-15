locals {
  project_id = var.project_id != null ? var.project_id : join("-", [var.name, random_id.project_id_suffix.hex])
  org_id     = var.folder_id != null ? null : var.org_id
  folder_id  = var.folder_id != null ? var.folder_id : null

  default_services = [
    "cloudbilling.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "essentialcontacts.googleapis.com",
    "iam.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "orgpolicy.googleapis.com",
    "servicenetworking.googleapis.com",
    "serviceusage.googleapis.com",
    "sqladmin.googleapis.com",
    "storage-component.googleapis.com",
    "storage.googleapis.com",
  ]
}

resource "random_id" "project_id_suffix" {
  byte_length = 4
}

resource "google_project" "project" {
  name                = var.name
  project_id          = local.project_id
  folder_id           = local.folder_id
  org_id              = local.org_id
  billing_account     = var.billing_account
  labels              = var.labels
  auto_create_network = var.auto_create_network
}

resource "google_project_service" "default_services" {
  for_each = toset(local.default_services)

  project                    = google_project.project.project_id
  service                    = each.value
  disable_dependent_services = false
  disable_on_destroy         = false
}

resource "google_project_service" "services" {
  for_each = toset(var.services)

  project                    = google_project.project.project_id
  service                    = each.value
  disable_dependent_services = var.disable_dependent_services
  disable_on_destroy         = var.disable_service_on_destroy
}

resource "google_project_default_service_accounts" "default_compute_sa" {
  count = var.disable_default_service_account == true ? 1 : 0

  action         = "DISABLE"
  project        = google_project.project.project_id
  restore_policy = "REVERT_AND_IGNORE_FAILURE"
}

resource "google_service_account" "managed_sa" {
  count = var.create_managed_service_account == true ? 1 : 0

  project      = google_project.project.project_id
  account_id   = var.managed_service_account_id
  display_name = "Terraform managed project service account"
}

resource "google_project_iam_member" "iam" {
  for_each = { for role in var.managed_sa_roles : role => role }

  project    = google_project.project.project_id
  role       = each.value
  member     = "serviceAccount:${google_service_account.managed_sa[0].email}"
  depends_on = [google_service_account.managed_sa]
}

resource "google_essential_contacts_contact" "contacts" {
  for_each = toset(var.essential_contacts)

  parent                              = "projects/${google_project.project.project_id}"
  email                               = each.key
  language_tag                        = "en-GB"
  notification_category_subscriptions = ["ALL"]
}

resource "google_compute_project_metadata_item" "oslogin" {
  project = google_project.project.project_id

  key   = "enable-oslogin"
  value = var.oslogin
}

resource "google_compute_project_metadata_item" "osconfig" {
  project = google_project.project.project_id

  key   = "enable-osconfig"
  value = "TRUE"
}
