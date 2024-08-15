variable "parent_folder" {
  type        = string
  description = "GCP - Parent folder number"
}

variable "billing_account" {
  type        = string
  description = "GCP - Billing account ID"
}

variable "prefix" {
  type        = string
  description = "Prefix for all resource names"
}

variable "default_region" {
  type        = string
  description = "GCP - Default region for all resources"
}

variable "domain" {
  type        = string
  description = "Top domain e.g. mydomain.com"
}

/*
variable "wif" {
  type = object({
    pool_name            = string
    github_provider_name = optional(string, "github")
    github_organization  = string
    service_accounts = map(object({
      display_name     = optional(string)
      github_condition = optional(string)
    }))
  })
  description = "Workload Identity Federation config"
}
*/
