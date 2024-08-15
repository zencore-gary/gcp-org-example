# Google Service Accounts*

resource "google_service_account" "marketplace_backend" {
  project      = module.project.project_id
  account_id   = "${var.prefix}-${var.environment}-backend"
  display_name = "${var.prefix}-${var.environment}-backend"
}

resource "google_service_account" "external_secrets" {
  project      = module.project.project_id
  account_id   = "${var.prefix}-${var.environment}-external-secrets"
  display_name = "${var.prefix}-${var.environment}-external-secrets"
}

resource "google_service_account" "cert_manager" {
  project      = module.project.project_id
  account_id   = "${var.prefix}-${var.environment}-cert-manager"
  display_name = "${var.prefix}-${var.environment}-cert-manager"
}

# Attach Google Service Accounts to Kubernetes Services Accounts using GKE specific annotation key
locals {
  wi_annotation_key = "iam.gke.io/gcp-service-account"
}

resource "google_project_iam_member" "marketplace_pubsub" {
  project = module.project.project_id
  role    = "roles/iam.workloadIdentityUser"
  member  = "serviceAccount:${module.project.project_id}.svc.id.goog[marketplace/pubsub-marketplace]"
}

resource "google_project_iam_member" "marketplace_jwt" {
  project = module.project.project_id
  role    = "roles/iam.workloadIdentityUser"
  member  = "serviceAccount:${module.project.project_id}.svc.id.goog[marketplace/jwt-marketplace]"
}

resource "google_project_iam_member" "marketplace_backend_pubsub_editor" {
  project = module.project.project_id
  role    = "roles/pubsub.editor"
  member  = "serviceAccount:${google_service_account.marketplace_backend.email}"
}

resource "google_project_iam_member" "marketplace_backend_datastore_user" {
  project = module.project.project_id
  role    = "roles/datastore.user"
  member  = "serviceAccount:${google_service_account.marketplace_backend.email}"
}

resource "google_project_iam_member" "external_secrets" {
  project = module.project.project_id
  role    = "roles/iam.workloadIdentityUser"
  member  = "serviceAccount:${module.project.project_id}.svc.id.goog[external-secrets/external-secrets]"
}

# Allow External Secrets to access/read any secrets from this project
resource "google_project_iam_member" "external_secrets_secretmanager_secretaccessor" {
  project = module.project.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.external_secrets.email}"
}

resource "google_project_iam_member" "cert_manager" {
  project = module.project.project_id
  role    = "roles/iam.workloadIdentityUser"
  member  = "serviceAccount:${module.project.project_id}.svc.id.goog[cert-manager/cert-manager]"
}

resource "google_project_iam_member" "cert_manager_dns_admin" {
  project = module.project.project_id
  role    = "roles/dns.admin"
  member  = "serviceAccount:${google_service_account.cert_manager.email}"
}
