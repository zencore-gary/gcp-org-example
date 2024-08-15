locals {
  labels = {
    env     = var.environment
    purpose = "blockapt"
    owner   = "zencore"
  }
  secondary_ip_range_pods     = "secondary-pods"
  secondary_ip_range_services = "secondary-services"

  domain = "${var.environment}.${var.parent_domain}"
}

module "project" {
  source                          = "../../modules/project"
  name                            = "${var.prefix}-${var.environment}"
  billing_account                 = var.billing_account
  folder_id                       = var.parent_folder
  disable_default_service_account = true
  create_managed_service_account  = false
  disable_service_on_destroy      = true
  labels                          = local.labels

  services = [
    "certificatemanager.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "dns.googleapis.com",
    "iap.googleapis.com",
    "secretmanager.googleapis.com",
  ]
  oslogin = "FALSE"
}

### GKE

module "cluster" {
  for_each = { for region in var.regions : region.name => region }

  source     = "../../modules/gke"
  project_id = module.project.project_id
  name       = "${var.environment}-${each.value.name}"
  prefix     = var.prefix

  regional = true
  region   = each.value.region

  network           = module.network.vpc.name
  subnetwork        = google_compute_subnetwork.subnets[each.key].name
  ip_range_services = local.secondary_ip_range_pods
  ip_range_pods     = local.secondary_ip_range_services
  ip_range_master   = each.value.master

  node_pools = [
    {
      name         = "system",
      machine_type = "e2-standard-2"
      min_count    = 1
      # TODO - Too weak in production
      upgrade_max_surge       = 1
      upgrade_max_unavailable = 1

      # Custom Kubernetes labels and taints
      labels = { scope = "system" }
      taints = [{
        # Allow GKE managed components
        key    = "components.gke.io/gke-managed-components"
        value  = "true"
        effect = "NO_SCHEDULE"
      }]
    },
    {
      name         = "workload",
      machine_type = "e2-standard-4"
      min_count    = 1
      # TODO - Too weak in production
      upgrade_max_surge       = 1
      upgrade_max_unavailable = 1

      # Custom Kubernetes labels and taints
      labels = { scope = "workload" }
      taints = [{
        key    = "scope"
        value  = "workload"
        effect = "NO_SCHEDULE"
      }]
    },
  ]

  deletion_protection = true
  release_channel     = "STABLE"

  registry_project_ids = [var.shared_project_id]

  labels = local.labels

  depends_on = [module.project]
}

module "bastion" {
  for_each = { for region in var.regions : region.name => region }

  source = "../../modules/bastion"

  region     = each.value.region
  project_id = module.project.project_id
  name       = "${var.environment}-${each.value.name}"
  prefix     = var.prefix

  network    = module.network.vpc.self_link
  subnetwork = google_compute_subnetwork.subnets[each.key].self_link

  type = "e2-standard-2" # 2 vCPUs, 8GB memory

  depends_on = [module.project]
}

resource "google_compute_global_address" "ingress_public_ip" {
  name         = "${var.prefix}-${var.environment}"
  project      = module.project.project_id
  address_type = "EXTERNAL"
}

resource "google_compute_security_policy" "blockapt_armor_policy" {
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

  # CVE-2021-44228 (Checkov CKV_GCP_73)
  # https://docs.prismacloud.io/en/enterprise-edition/policy-reference/google-cloud-policies/google-cloud-networking-policies/ensure-cloud-armor-prevents-message-lookup-in-log4j2
  rule {
    action   = "deny(403)"
    priority = 1
    match {
      expr {
        expression = "evaluatePreconfiguredExpr('cve-canary')"
      }
    }
  }
}

/*
module "iap" {
  source = "../../modules/iap"

  project_id = module.project.project_id
  host       = "argo.${local.domain}"
}
*/
