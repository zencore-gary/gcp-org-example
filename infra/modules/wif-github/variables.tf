variable "project_id" {
  type        = string
  description = "The ID of the GCP project"
}

variable "project_number" {
  type        = string
  description = "The number of the GCP project"
}

variable "name" {
  type        = string
  description = "Name of the WIF pool"
}

variable "display_name" {
  type        = string
  description = "Display name of the WIF pool"
  default     = null
}

variable "description" {
  type        = string
  description = "Description of the WIF pool"
  default     = ""
}

variable "github_provider_name" {
  type        = string
  description = "Name for the Github WIF provider"
}

variable "github_organization" {
  type        = string
  description = "Name of the Github org - will be used on the WIF provider condition."
}

variable "service_accounts" {
  type = map(object({
    display_name     = optional(string)
    github_condition = optional(string)
  }))
  description = "The list of service accounts to set up with WIF. Map keys are the service account IDs."
  default     = {}
}

