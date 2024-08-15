variable "org_id" {
  description = "The organization id"
  type        = string
  default     = null
}

variable "name" {
  description = "project display name"
  type        = string
}

variable "project_id" {
  description = "Project ID"
  type        = string
  default     = null
}

variable "auto_create_network" {
  description = "Controls whether the 'default' network exists on the project. Defaults set to false, the default network will still be created by GCP but will be deleted immediately by Terraform."
  type        = bool
  default     = false
}

variable "billing_account" {
  description = "billing account id"
  type        = string
}

variable "folder_id" {
  description = "parent folder id"
  type        = string
  default     = null
}

variable "labels" {
  description = "Resource labels required for deployment."
  type = object({
    env     = string
    purpose = string
    owner   = string
  })
  nullable = false
}

variable "services" {
  description = "The list of services to enable on the project."
  type        = list(string)
  default     = []
}

variable "disable_dependent_services" {
  description = "Disable dependent services when disabling a service."
  type        = bool
  default     = true
}

variable "disable_service_on_destroy" {
  description = "Disable services when destroying the project."
  type        = bool
  default     = true
}

variable "disable_default_service_account" {
  description = "The default service account behavior."
  type        = bool
  default     = false
}

variable "create_managed_service_account" {
  description = "Create a service account for the project."
  type        = bool
  default     = false
}

variable "managed_service_account_id" {
  description = "The service account to create."
  type        = string
  default     = "tf-managed-sa"
}

variable "managed_sa_roles" {
  description = "The roles to assign to the service account."
  type        = list(string)
  default     = []
}

variable "essential_contacts" {
  type        = list(string)
  description = "List of essential contacts (by email)"
  default     = []
}

variable "oslogin" {
  type        = string
  description = "Enable OSLogin"
  default     = "TRUE"
}
