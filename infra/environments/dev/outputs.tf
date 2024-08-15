output "project" {
  value       = module.project.project_id
  description = "Project ID"
}

output "bastion" {
  value       = module.bastion[*]
  description = "Bastion"
}

output "cluster" {
  value       = module.cluster[*]
  description = "GKE"
}

output "public_ip" {
  value       = google_compute_global_address.ingress_public_ip.address
  description = "Public IP for Gateway"
}

output "public_ip_name" {
  value       = google_compute_global_address.ingress_public_ip.name
  description = "Value for key spec.addresses[0].value in Kubernetes Gateway"
}

output "security_policy_name" {
  value       = google_compute_security_policy.blockapt_armor_policy.name
  description = "Value for key spec.default.securityPolicy in Kubernetes GCPBackendPolicy"
}

output "sa_annotation_mysql_admins" {
  value       = [for c in module.cloudsql : c.admin_email]
  description = "MySQL admin - Kubernetes SA annotation values to use Google Service Account"
}

output "sa_annotation_external_secrets" {
  value       = google_service_account.external_secrets.email
  description = "External Secrets - Kubernetes SA annotation value to use Google Service Account"
}

output "sa_annotation_cert_manager" {
  value       = google_service_account.cert_manager.email
  description = "cert-manager - Kubernetes SA annotation value to use Google Service Account"
}

output "cloud_sql_proxy_connection_names" {
  value       = [for c in module.cloudsql : c.connection_name]
  description = "CloudSQL proxy - Instance connection name"
}

output "cloud_sql_admins" {
  value       = [for c in module.cloudsql : c.admin_username]
  description = "CloudSQL proxy - Admin username"
}

output "cloud_sql_users" {
  value       = [for m in module.mysql_iam_users : m.users]
  description = "CloudSQL proxy - Admin username"
}
