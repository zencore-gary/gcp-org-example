resource "google_service_account" "cloudbuild_worker_pool" {
  project      = var.project_id
  account_id   = "${var.prefix}-${var.name}-${random_id.postfix.hex}"
  display_name = "${var.prefix}-${var.name}-${random_id.postfix.hex}"
}

resource "google_project_iam_member" "roles_registry" {
  project = var.project_id
  role    = "roles/artifactregistry.createOnPushWriter"
  member  = "serviceAccount:${google_service_account.cloudbuild_worker_pool.email}"
}

resource "google_project_iam_member" "roles_logging" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.cloudbuild_worker_pool.email}"
}

resource "google_project_iam_member" "roles_serviceagent" {
  project = var.project_id
  role    = "roles/cloudbuild.loggingServiceAgent"
  member  = "serviceAccount:${google_service_account.cloudbuild_worker_pool.email}"
}

resource "google_project_iam_member" "rols_build" {
  project = var.project_id
  role    = "roles/cloudbuild.builds.builder"
  member  = "serviceAccount:${google_service_account.cloudbuild_worker_pool.email}"
}

resource "google_project_iam_member" "roles_workerpool" {
  project = var.project_id
  role    = "roles/cloudbuild.workerPoolUser"
  member  = "serviceAccount:${google_service_account.cloudbuild_worker_pool.email}"
}
