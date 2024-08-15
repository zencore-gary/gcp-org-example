resource "google_compute_network" "vpc" {
  project                 = var.project_id
  name                    = "${var.prefix}-${var.name}"
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
}

resource "google_compute_global_address" "private_ip_alloc" {
  name          = "${var.prefix}-${var.name}-private-ip-alloc"
  project       = var.project_id
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.self_link
}

resource "google_service_networking_connection" "svc_network_peering" {
  network                 = google_compute_network.vpc.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
}

resource "google_project_service_identity" "servicenetworking_agent" {
  provider = google-beta

  project = var.project_id
  service = "servicenetworking.googleapis.com"
}

resource "google_project_iam_member" "servicenetworking_agent" {
  project = var.project_id
  role    = "roles/servicenetworking.serviceAgent"
  member  = "serviceAccount:${google_project_service_identity.servicenetworking_agent.email}"
}

resource "google_compute_firewall" "deny_all" {
  project = var.project_id
  name    = "${var.prefix}-${var.name}-deny-all"
  network = google_compute_network.vpc.name

  priority = 65535

  deny {
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]

}

resource "google_compute_firewall" "ingress_allow_iap" {
  project = var.project_id
  name    = "${var.prefix}-${var.name}-ingress-allow-iap"
  network = google_compute_network.vpc.name

  priority = 200

  allow {
    protocol = "tcp"
  }

  source_ranges = ["35.235.240.0/20"]
}
