module "logging_project" {
  source                          = "../../modules/project"
  name                            = "${var.prefix}-logging"
  billing_account                 = var.billing_account
  folder_id                       = module.shared_folder.folder_id
  disable_default_service_account = true
  create_managed_service_account  = false
  disable_service_on_destroy      = true
  labels                          = local.labels
  services = [
    "storage.googleapis.com",
  ]
}

resource "random_id" "logging_bucket_suffix" {
  byte_length = 4
}

resource "google_storage_bucket" "logging" {
  #checkov:skip=CKV_GCP_78:Logs storage does not need versioning
  project  = module.logging_project.project_id
  location = var.log_location
  name     = "${var.prefix}-logging-${random_id.logging_bucket_suffix.hex}"

  force_destroy               = false
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = false
  }

  labels = local.labels

  depends_on = [module.logging_project]
}

resource "google_logging_project_bucket_config" "logging" {
  project   = module.logging_project.project_id
  location  = var.log_location
  bucket_id = google_storage_bucket.logging.name

  retention_days   = var.log_retention_days
  enable_analytics = true
}

module "shared_logging" {
  source = "../../modules/logging"

  name      = "shared-logging"
  folder_id = module.shared_folder.folder_id

  project_id = module.logging_project.project_id
  bucket_id  = google_storage_bucket.logging.name
  location   = var.log_location
}

module "dev_logging" {
  source = "../../modules/logging"

  name      = "dev-logging"
  folder_id = module.dev_folder.folder_id

  project_id = module.logging_project.project_id
  bucket_id  = google_storage_bucket.logging.name
  location   = var.log_location
}

