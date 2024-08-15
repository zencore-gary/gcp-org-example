resource "random_id" "postfix" {
  byte_length = 4
}

### GCP Service Account

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

### GKE control plane

resource "google_container_cluster" "cluster" {
  name        = "${var.prefix}-${var.name}-${random_id.postfix.hex}"
  description = var.description
  project     = var.project_id

  location = local.location

  network             = "projects/${local.network_project_id}/global/networks/${var.network}"
  subnetwork          = "projects/${local.network_project_id}/regions/${local.region}/subnetworks/${var.subnetwork}"
  networking_mode     = "VPC_NATIVE"
  deletion_protection = var.deletion_protection

  # We can't create a cluster with no node pool defined, but we want to only use separately managed node pools,
  # so we create the smallest possible default node pool and immediately delete it
  remove_default_node_pool = true
  initial_node_count       = 1

  node_config {
    service_account = google_service_account.cluster.email
    resource_labels = var.labels
  }

  datapath_provider = "ADVANCED_DATAPATH"

  ip_allocation_policy {
    cluster_secondary_range_name  = var.ip_range_pods
    services_secondary_range_name = var.ip_range_services
    stack_type                    = var.stack_type
  }

  cost_management_config {
    enabled = var.enable_cost_allocation
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
    master_ipv4_cidr_block  = var.ip_range_master

    #private_endpoint_subnetwork = "projects/${local.network_project_id}/regions/${local.region}/subnetworks/${var.subnetwork}"

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

  gateway_api_config {
    channel = "CHANNEL_STANDARD"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  timeouts {
    create = "45m"
    update = "45m"
    delete = "45m"
  }

  resource_labels = var.labels
}

### GKE node pools

resource "google_container_node_pool" "node_pools" {
  for_each = { for node_pool in var.node_pools : node_pool.name => node_pool }

  project  = var.project_id
  location = local.location
  cluster  = google_container_cluster.cluster.name

  name = "${each.value.name}-${random_id.postfix.hex}"

  node_config {
    image_type   = lookup(each.value, "image_type", "COS_CONTAINERD")
    machine_type = lookup(each.value, "machine_type", "n1-standard-2")

    service_account = google_service_account.cluster.email
    oauth_scopes    = local.node_oauth_scopes

    disk_size_gb = lookup(each.value, "disk_size_gb", 100)
    # Choose from: pd-standard, pd-balanced, pd-ssd or pd-extreme
    disk_type = lookup(each.value, "disk_type", "pd-balanced")

    preemptible = lookup(each.value, "preemptible", false)

    metadata = {
      "disable-legacy-endpoints" = "true"
    }

    resource_labels = var.labels

    labels = lookup(each.value, "labels", null)

    dynamic "taint" {
      for_each = lookup(each.value, "taints", null)
      content {
        key    = taint.value["key"]
        value  = lookup(taint.value, "value", null)
        effect = lookup(taint.value, "effect", null)
      }
    }

    shielded_instance_config {
      enable_secure_boot          = "true"
      enable_integrity_monitoring = "true"
    }

    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }

  initial_node_count = lookup(
    each.value,
    "initial_node_count",
    lookup(each.value, "min_count", 1),
  )

  node_count = lookup(each.value, "autoscaling", true) ? null : lookup(each.value, "min_count", 1)

  dynamic "autoscaling" {
    for_each = lookup(each.value, "autoscaling", true) ? [each.value] : []
    content {
      min_node_count = lookup(autoscaling.value, "min_count", 1)
      max_node_count = lookup(autoscaling.value, "max_count", 100)
    }
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  upgrade_settings {
    max_surge       = lookup(each.value, "upgrade_max_surge", null)
    max_unavailable = lookup(each.value, "upgrade_max_unavailable", null)
  }

  timeouts {
    create = "30m"
    update = "40m"
    delete = "2h"
  }

  lifecycle {
    create_before_destroy = true
  }
}
