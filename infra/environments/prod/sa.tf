## Google Service Accounts for GKE Workload Identity usage (Kubernetes Service Accounts)

# Cert-manager

resource "google_service_account" "cert_manager" {
  project      = module.project.project_id
  account_id   = "${var.prefix}-${var.environment}-cert-manager"
  display_name = "${var.prefix}-${var.environment}-cert-manager"
}

resource "google_project_iam_member" "cert_manager" {
  depends_on = [module.cluster]

  project = module.project.project_id
  role    = "roles/iam.workloadIdentityUser"
  member  = "serviceAccount:${module.project.project_id}.svc.id.goog[cert-manager/cert-manager]"
}

# Allow Cert-manager to manage any Cloud DNS from this project
resource "google_project_iam_member" "cert_manager_dns_admin" {
  project = module.project.project_id
  role    = "roles/dns.admin"
  member  = "serviceAccount:${google_service_account.cert_manager.email}"
}

# External-secrets

resource "google_service_account" "external_secrets" {
  project      = module.project.project_id
  account_id   = "${var.prefix}-${var.environment}-external-secrets"
  display_name = "${var.prefix}-${var.environment}-external-secrets"
}

resource "google_project_iam_member" "external_secrets" {
  depends_on = [module.cluster]

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
