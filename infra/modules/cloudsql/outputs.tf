output "name" {
  value       = google_sql_database_instance.this.name
  description = "Cloud SQL instance name"
}

output "connection_name" {
  value       = google_sql_database_instance.this.connection_name
  description = "Connection name - Format: <project>:<region>:<instance>"
}

output "admin_email" {
  value       = google_service_account.mysql_admin.email
  description = "Admin username"
}

output "admin_username" {
  value       = google_sql_user.mysql_admin.name
  description = "Admin username"
}

output "admin_password" {
  value       = google_sql_user.mysql_admin.password
  description = "Admin password (stored in Google Cloud Secret Manager)"
  sensitive   = true
}
