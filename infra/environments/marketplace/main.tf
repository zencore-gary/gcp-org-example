locals {
  labels = {
    env     = "prod"
    purpose = "marketplace"
    owner   = "zencore"
  }
  secondary_ip_range_pods     = "secondary-pods"
  secondary_ip_range_services = "secondary-services"
}

module "project" {
  source                          = "../../modules/project"
  name                            = "${var.prefix}-public"
  billing_account                 = var.billing_account
  folder_id                       = var.parent_folder
  disable_default_service_account = true
  create_managed_service_account  = false
  disable_service_on_destroy      = true
  labels                          = local.labels
  services = [
    "container.googleapis.com",
    "iap.googleapis.com",
    "osconfig.googleapis.com",
    "secretmanager.googleapis.com",
  ]
  oslogin = "FALSE"
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "google_storage_bucket" "terraform_state" {
  project                     = module.project.project_id
  name                        = "${var.prefix}-marketplacedata-${random_id.bucket_suffix.hex}"
  location                    = "EU"
  force_destroy               = false
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }

  labels = local.labels

  depends_on = [module.project]
}

module "cluster" {
  count      = length(var.regions)
  source     = "../../modules/gke-autopilot"
  project_id = module.project.project_id
  name       = "${var.environment}-${var.regions[count.index]["name"]}"
  prefix     = var.prefix

  regional = true
  region   = var.regions[count.index]["region"]

  network           = module.network.vpc.name
  subnetwork        = google_compute_subnetwork.subnets[count.index].name
  ip_range_services = local.secondary_ip_range_pods
  ip_range_pods     = local.secondary_ip_range_services

  autopilot = true

  registry_project_ids = [var.shared_project_id]

  depends_on = [module.project]
}

module "network" {
  source     = "../../modules/network/vpc"
  project_id = module.project.project_id
  name       = "${var.environment}-vpc"
  prefix     = var.prefix
}

resource "google_compute_subnetwork" "subnets" {
  count                    = length(var.regions)
  project                  = module.project.project_id
  name                     = "${var.prefix}-${var.environment}-${var.regions[count.index]["name"]}"
  network                  = module.network.vpc.self_link
  region                   = var.regions[count.index]["region"]
  private_ip_google_access = true
  ip_cidr_range            = var.regions[count.index]["cidr"]
  secondary_ip_range = [
    {
      range_name    = local.secondary_ip_range_pods
      ip_cidr_range = var.regions[count.index]["secondary_pods"]
    },
    {
      range_name    = local.secondary_ip_range_services
      ip_cidr_range = var.regions[count.index]["secondary_services"]
    },
  ]
}

module "cloudnat" {
  source     = "../../modules/network/cloudnat"
  project_id = module.project.project_id

  name   = var.environment
  prefix = var.prefix

  vpc     = module.network.vpc.self_link
  subnets = google_compute_subnetwork.subnets
}

module "bastion" {
  count  = length(var.regions)
  source = "../../modules/bastion"

  region     = var.regions[count.index]["region"]
  zone       = "${var.regions[count.index]["region"]}-b"
  project_id = module.project.project_id
  name       = "${var.environment}-${var.regions[count.index]["name"]}"
  prefix     = var.prefix

  network    = module.network.vpc.self_link
  subnetwork = google_compute_subnetwork.subnets[count.index].self_link

  type = "e2-standard-2" # 2 vCPUs, 8GB memory

  depends_on = [module.project]
}

resource "google_compute_global_address" "ingress_public_ip" {
  name         = "${var.prefix}-${var.environment}"
  project      = module.project.project_id
  address_type = "EXTERNAL"
}

resource "google_compute_security_policy" "cloud_armor_policy" {
  name        = "${var.prefix}-${var.environment}-policy"
  project     = module.project.project_id
  description = "Basic security policy for web application"

  # Allow all traffic by default
  rule {
    action   = "allow"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "default rule"
  }
}

module "iap" {
  source = "../../modules/iap"

  project_id = module.project.project_id
  host       = "argo.${var.environment}.${var.parent_domain}"
}
