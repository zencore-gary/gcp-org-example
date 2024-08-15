output "shared_project" {
  value       = module.project.project_id
  description = "GCP - Shared project ID"
}

output "dns_name" {
  value       = google_dns_managed_zone.dns.name
  description = "GCP - DNS zone name"
}

output "dns_zone" {
  value       = google_dns_managed_zone.dns.dns_name
  description = "GCP - DNS name"
}

output "dns_name_servers" {
  value       = google_dns_managed_zone.dns.name_servers
  description = "GCP - DNS name servers"
}

output "tf_state_bucket" {
  value       = google_storage_bucket.tf_state.name
  description = "Terraform state bucket name"
}

output "docker_registry" {
  value       = "${var.default_region}-docker.pkg.dev/${module.project.project_id}/${google_artifact_registry_repository.docker.repository_id}"
  description = "Docker registry URL"
}
