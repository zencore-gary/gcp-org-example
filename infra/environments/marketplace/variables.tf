variable "environment" {
  type        = string
  description = "Environment name"
}

variable "parent_folder" {
  type        = string
  description = "GCP - Parent project folder path"
}

variable "billing_account" {
  type        = string
  description = "GCP - Billing account ID"
}

variable "prefix" {
  type        = string
  description = "Prefix for all resource names"
}

variable "regions" {
  type        = list(any)
  description = "GCP - Region(s) for all resources"
}

variable "shared_project_id" {
  type        = string
  description = "GCP - Shared project ID"
}

variable "parent_domain" {
  type        = string
  description = "Parent Domain e.g.  mydomain.com"
}
