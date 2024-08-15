output "display_name" {
  description = "Folder display name."
  value       = google_folder.this.display_name
}

output "name" {
  description = "Folder name in format folders/{folder_id}."
  value       = google_folder.this.name
}

output "folder_id" {
  description = "Folder number"
  value       = google_folder.this.id
}
