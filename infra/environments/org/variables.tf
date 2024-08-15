variable "parent_folder" {
  type        = string
  description = "GCP - Parent project folder path"
}

variable "log_location" {
  type        = string
  description = "Location for the Log Bucket"
}

variable "log_retention_days" {
  type        = number
  description = "(Optional) Logging retention in days"
  default     = 365
}

variable "billing_account" {
  type        = string
  description = "GCP - Billing account ID"
}

variable "prefix" {
  type        = string
  description = "Prefix for all resource names"
}
