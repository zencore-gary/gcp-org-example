variable "project_id" {
  type        = string
  description = "(Required) Project ID to provision the cluster"
}

variable "iap_members" {
  description = "Custom IAP authorized members"
  type        = list(string)
  default     = []
}

variable "host" {
  description = "Filter specific host (scope IAP access)"
  type        = string
}
