locals {
  location           = var.regional ? var.region : var.zones[0]
  region             = var.regional ? var.region : join("-", slice(split("-", var.zones[0]), 0, 2))
  network_project_id = var.network_project_id != "" ? var.network_project_id : var.project_id
  zone_count         = length(var.zones)

  # For regional cluster - use var.zones if provided, use available otherwise, for zonal cluster use var.zones with first element extracted
  node_locations = var.regional ? coalescelist(compact(var.zones), try(sort(random_shuffle.available_zones[0].result), [])) : slice(var.zones, 1, length(var.zones))
}

data "google_compute_zones" "available" {
  count = local.zone_count == 0 ? 1 : 0

  provider = google-beta

  project = var.project_id
  region  = var.region
}

resource "random_shuffle" "available_zones" {
  count = local.zone_count == 0 ? 1 : 0

  input        = data.google_compute_zones.available[0].names
  result_count = 3
}

resource "random_id" "postfix" {
  byte_length = 4
}

resource "google_container_cluster" "cluster" {
  provider = google-beta

  name        = "${var.prefix}-${var.name}"
  description = var.description
  project     = var.project_id

  location       = local.location
  node_locations = local.node_locations

  network             = "projects/${local.network_project_id}/global/networks/${var.network}"
  subnetwork          = "projects/${local.network_project_id}/regions/${local.region}/subnetworks/${var.subnetwork}"
  networking_mode     = "VPC_NATIVE"
  deletion_protection = var.deletion_protection

  ip_allocation_policy {
    cluster_secondary_range_name  = var.ip_range_pods
    services_secondary_range_name = var.ip_range_services
    stack_type                    = var.stack_type
  }

  enable_autopilot = var.autopilot

  cost_management_config {
    enabled = var.enable_cost_allocation
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true

    master_global_access_config {
      enabled = true
    }
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.0.0.0/16"
      display_name = "all"
    }
  }

  release_channel {
    channel = var.release_channel
  }

  timeouts {
    create = "45m"
    update = "45m"
    delete = "45m"
  }

  resource_labels = var.labels
}

locals {
  registry_projects_list = length(var.registry_project_ids) == 0 ? [var.project_id] : var.registry_project_ids
}

resource "google_service_account" "cluster" {
  project      = var.project_id
  account_id   = "${var.prefix}-${var.name}-${random_id.postfix.hex}"
  display_name = "${var.prefix}-${var.name}-${random_id.postfix.hex}"
}

resource "google_project_iam_member" "roles_container_defaultnodeserviceaccount" {
  project = google_service_account.cluster.project
  role    = "roles/container.defaultNodeServiceAccount"
  member  = google_service_account.cluster.member
}

resource "google_project_iam_member" "roles_storage_objectviewer" {
  for_each = toset(local.registry_projects_list)

  project = each.key
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.cluster.email}"
}

resource "google_project_iam_member" "roles_artifactregistry_reader" {
  for_each = toset(local.registry_projects_list)

  project = each.key
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.cluster.email}"
}
