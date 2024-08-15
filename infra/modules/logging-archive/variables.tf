variable "name" {
  type        = string
  description = "(Required) Name for resources"
}

variable "project_id" {
  type        = string
  description = "(Required) Project ID to provision the logging"
}

variable "folder_id" {
  type        = string
  description = "(Required) Folder ID to provision the logging"
}

variable "location" {
  type        = string
  description = "(Optional) Logging bucket location"
  default     = "EU"
}

variable "retention_days" {
  type        = number
  description = "(Required) Logging retention in days"
  default     = 1095
}

variable "expiration_days" {
  type        = number
  description = "(Required) Logging expiration in days"
  default     = 1096
}

variable "filter" {
  type        = string
  description = "(Optional) Folder logging sink filter"
  default     = ""
}

variable "lock" {
  type        = bool
  description = "(Optional) Lock storage bucket"
  default     = false
}

variable "exclusions" {
  type = list(object({
    name        = string
    description = string
    filter      = string
  }))
  description = "(Optional) Folder logging sink exclusions (concatenated with defaults)"
  default     = []
}

variable "labels" {
  description = "(Optional) A map of key/value label pairs to assign to the bucket"
  type        = map(any)
  default     = {}
}
