output "marketplace_project" {
  value       = module.project.project_id
  description = "GCP - Marketplace project ID"
}

output "test_topic" {
  value       = google_pubsub_topic.marketplace_backend.name
  description = "GCP - Test topic name"
}

output "public_ip" {
  value       = google_compute_global_address.ingress_public_ip.address
  description = "Public IP for GKE Gateway"
}

output "public_ip_name" {
  value       = google_compute_global_address.ingress_public_ip.name
  description = "Value for key spec.addresses[0].value in Kubernetes Gateway"
}

output "security_policy_name" {
  value       = google_compute_security_policy.cloud_armor_policy.name
  description = "Value for key spec.default.securityPolicy in Kubernetes GCPBackendPolicy"
}

output "sa_annotation_marketplace" {
  value       = <<YAML
${local.wi_annotation_key}: "${google_service_account.marketplace_backend.email}"
YAML
  description = "Marketplace backend integration - Kubernetes service account annotation to use Google Service Account"
}

output "sa_annotation_external_secrets" {
  value       = <<YAML
${local.wi_annotation_key}: "${google_service_account.external_secrets.email}"
YAML
  description = "External Secrets - Kubernetes service account annotation to use Google Service Account"
}

output "sa_annotation_cert_manager" {
  value       = <<YAML
${local.wi_annotation_key}: "${google_service_account.cert_manager.email}"
YAML
  description = "cert-manager - Kubernetes service account annotation to use Google Service Account"
}

output "debug" {
  value = local.loop_users
}
