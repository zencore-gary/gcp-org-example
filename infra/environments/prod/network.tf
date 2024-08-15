module "network" {
  source     = "../../modules/network/vpc"
  project_id = module.project.project_id
  name       = "${var.environment}-vpc"
  prefix     = var.prefix
}

resource "google_compute_subnetwork" "subnets" {
  for_each = { for region in var.regions : region.name => region }

  project                  = module.project.project_id
  name                     = "${var.prefix}-${var.environment}-${each.key}"
  network                  = module.network.vpc.self_link
  region                   = each.value.region
  private_ip_google_access = true
  ip_cidr_range            = each.value.cidr
  secondary_ip_range = [
    {
      range_name    = local.secondary_ip_range_pods
      ip_cidr_range = each.value.secondary_pods
    },
    {
      range_name    = local.secondary_ip_range_services
      ip_cidr_range = each.value.secondary_services
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
