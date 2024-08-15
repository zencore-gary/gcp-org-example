variable "display_name" {
  description = "Folder display name"
  type        = string
}

variable "parent" {
  description = "Parent in folders/folder_id or organizations/org_id format"
  type        = string
  validation {
    condition     = can(regex("(organizations|folders)/[0-9]+", var.parent))
    error_message = "Parent must be of the form folders/folder_id or organizations/organization_id"
  }
}
