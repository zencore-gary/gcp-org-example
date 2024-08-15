output "emails" {
  value       = [for m in google_service_account.mysql_users : m.email]
  description = "Service account emails"
}

output "users" {
  value       = [for m in google_sql_user.mysql_users : m.name]
  description = "CloudSQL usernames"
}
