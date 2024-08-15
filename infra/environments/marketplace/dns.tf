resource "google_dns_managed_zone" "dns" {
  project     = module.project.project_id
  name        = "marketplace"
  dns_name    = "marketplace.${var.parent_domain}."
  description = "DNS Zone"
}

resource "google_dns_record_set" "delegated_zone_record" {
  project = var.shared_project_id
  name    = "marketplace.${var.parent_domain}."

  type = "NS"
  ttl  = 60

  managed_zone = "gcp-zencore-dev" # From shared environment
  rrdatas      = google_dns_managed_zone.dns.name_servers
}

resource "google_dns_record_set" "wildcard_a_record" {
  project = module.project.project_id
  name    = "*.marketplace.${var.parent_domain}."

  type = "A"
  ttl  = 60

  managed_zone = google_dns_managed_zone.dns.name
  rrdatas      = [google_compute_global_address.ingress_public_ip.address]

}

resource "google_dns_record_set" "a_record" {
  project = module.project.project_id
  name    = "marketplace.${var.parent_domain}."

  type = "A"
  ttl  = 60

  managed_zone = google_dns_managed_zone.dns.name
  rrdatas      = [google_compute_global_address.ingress_public_ip.address]
}
