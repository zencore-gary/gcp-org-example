resource "google_compute_router" "router" {
  for_each = { for k, v in var.subnets : k => v }

  name = "${each.value.name}-nat-rtr"

  project = var.project_id
  region  = each.value.region
  network = var.vpc

  bgp {
    asn = 64514
  }
}

resource "google_compute_address" "ext_ip" {
  for_each = { for k, v in var.subnets : k => v }

  project = var.project_id
  region  = each.value.region

  name = "${each.value.name}-nat-ext-addr"
}

resource "google_compute_router_nat" "router_nat" {
  for_each = { for k, v in var.subnets : k => v }

  project = var.project_id
  region  = each.value.region

  name   = "${each.value.name}-nat-gw"
  router = google_compute_router.router[each.key].name

  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.ext_ip[each.key].self_link]
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = each.value.self_link
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  log_config {
    filter = "TRANSLATIONS_ONLY"
    enable = true
  }
}
