variable "name" {
  type        = string
  description = "(Required) Name for resources"
}

variable "folder_id" {
  type        = string
  description = "(Required) Target folder ID"
}

variable "project_id" {
  type        = string
  description = "(Required) Target project ID with the logging bucket"
}

variable "bucket_id" {
  type        = string
  description = "(Required) Target bucket ID"
}

variable "location" {
  type        = string
  description = "(Required) Logging bucket location"
  default     = "global"
}

variable "filter" {
  type        = string
  description = "(Optional) Folder logging sink filter"
  default     = ""
}

variable "exclusions" {
  type = list(object({
    name        = string
    description = string
    filter      = string
  }))
  description = "(Optional) Folder logging sink exclusions concatenated with defaults"
  default     = []
}
