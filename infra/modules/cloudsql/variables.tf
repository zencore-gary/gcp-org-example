variable "project_id" {
  type        = string
  description = "(Required) Project ID to provision the cluster"
}

variable "prefix" {
  type        = string
  description = "(Required) The prefix e.g. dev/prod or blue/green"
}

variable "name" {
  type        = string
  description = "(Required) The name of the cluster"
}

variable "region" {
  type        = string
  description = "(Required) The Region the instance should be provisioned in"
}

variable "tier" {
  type        = string
  description = "(Optional) The instance tier"
  default     = "db-f1-micro"
}

variable "database_version" {
  type        = string
  description = "(Optional) The database version to use"
  default     = "MYSQL_8_0"
}

variable "deletion_protection" {
  type        = bool
  description = "Enforce deletion protection on the database instance (default false)"
  default     = false
}

variable "vpc" {
  type        = string
  description = "The VPC network to connect the instance to"
}

variable "general_logging" {
  type        = bool
  description = "View SQL queries executed on the database instance in logs"
  default     = false
}

variable "extra_flags" {
  description = "List of CloudSQL flags that are applied to the database server"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "path" {
  type        = string
  description = "(Required) The Kubernetes resource path, format: <namespace>/<service_account_name>"
}
