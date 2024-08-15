resource "google_dns_managed_zone" "dns" {
  project     = module.project.project_id
  name        = "${var.prefix}-shared"
  dns_name    = "${var.domain}."
  description = "Top DNS Zone"

  depends_on = [module.project]
}
