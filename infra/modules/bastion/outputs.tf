output "name" {
  value       = google_compute_instance.this.name
  description = "VM instance name"
}

output "region" {
  value       = var.region
  description = "VM instance region"
}

output "zone" {
  value       = google_compute_instance.this.zone
  description = "VM instance zone"
}

output "sa" {
  value       = google_service_account.bastion.email
  description = "VM instance service account"
}
