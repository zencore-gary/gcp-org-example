resource "google_dns_managed_zone" "dns" {
  project     = module.project.project_id
  name        = var.environment
  dns_name    = "${local.domain}."
  description = "DNS Zone"
}

/*
resource "google_dns_record_set" "deleg_zone_record" {
  project = var.shared_project_id
  name    = "${local.domain}."

  type = "NS"
  ttl  = 60

  managed_zone = var.parent_zone
  rrdatas      = google_dns_managed_zone.dns.name_servers
}
*/

resource "google_dns_record_set" "wildcard_a_record" {
  project = module.project.project_id
  name    = "*.${local.domain}."

  type = "A"
  ttl  = 60

  managed_zone = google_dns_managed_zone.dns.name
  rrdatas      = [google_compute_global_address.ingress_public_ip.address]

}

resource "google_dns_record_set" "a_record" {
  project = module.project.project_id
  name    = "${local.domain}."

  type = "A"
  ttl  = 60

  managed_zone = google_dns_managed_zone.dns.name
  rrdatas      = [google_compute_global_address.ingress_public_ip.address]
}
