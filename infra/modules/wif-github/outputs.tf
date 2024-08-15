output "wif_pool_id" {
  value       = google_iam_workload_identity_pool.this.id
  description = "Google IAM - Workload Identity - Pool ID"
}

output "wif_provider_id" {
  value       = google_iam_workload_identity_pool_provider.github.id
  description = "Google IAM - Workload Identity - Pool ID (GitHub provider)"
}

output "service_accounts" {
  value       = google_service_account.sa
  description = "Google Service Account(s) created"
}
