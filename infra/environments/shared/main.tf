locals {
  labels = {
    env     = "blockapt-shared"
    purpose = "blockapt-shared-infra"
    owner   = "zencore"
  }
}

module "project" {
  source                          = "../../modules/project"
  name                            = "${var.prefix}-shared"
  billing_account                 = var.billing_account
  folder_id                       = var.parent_folder
  disable_default_service_account = true
  create_managed_service_account  = false
  disable_service_on_destroy      = true
  labels                          = local.labels
  services = [
    "cloudbuild.googleapis.com",
    "artifactregistry.googleapis.com",
    "container.googleapis.com",
    "secretmanager.googleapis.com",
  ]
}

resource "google_artifact_registry_repository" "docker" {
  project       = module.project.project_id
  location      = var.default_region
  repository_id = "${var.prefix}-registry"
  description   = "Shared Docker Registry"
  format        = "DOCKER"

  depends_on = [module.project]
}

resource "random_id" "tf_state_bucket_suffix" {
  byte_length = 4
}

resource "google_storage_bucket" "tf_state" {
  project                     = module.project.project_id
  name                        = "${var.prefix}-tf-state-${random_id.tf_state_bucket_suffix.hex}"
  location                    = var.default_region
  force_destroy               = false
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }

  labels = local.labels

  depends_on = [module.project]
}

module "network" {
  source     = "../../modules/network/vpc"
  project_id = module.project.project_id
  name       = "vpc"
  prefix     = var.prefix
}

module "cloudbuild" {
  source       = "../../modules/cloudbuild"
  project_id   = module.project.project_id
  prefix       = var.prefix
  name         = "cloudbuild"
  network_name = module.network.vpc.id
  region       = var.default_region
}
