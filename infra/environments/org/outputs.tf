output "shared_folder" {
  value       = module.shared_folder.folder_id
  description = "shared folder number"
}

output "dev_folder" {
  value       = module.dev_folder.folder_id
  description = "dev folder number"
}

output "marketplace_folder" {
  value       = module.marketplace_folder.folder_id
  description = "marketplace folder number"
}
