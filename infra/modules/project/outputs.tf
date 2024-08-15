output "project_id" {
  description = "Project ID."
  value       = google_project.project.project_id
}

output "project_number" {
  description = "Project number."
  value       = google_project.project.number
}

output "enabled_services" {
  description = "Enabled APIs."
  value       = { for api in google_project_service.services : api.service => api.id }
}
