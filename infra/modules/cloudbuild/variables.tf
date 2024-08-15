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

variable "network_name" {
  type        = string
  description = "(Required) The name of the network to peer to"
}

variable "worker_pool_no_external_ip" {
  type        = bool
  default     = false
  description = "(Optional) Do not attach external public IP to worker pool"
}

variable "region" {
  type        = string
  description = "(Required) Region the worker pool should be provisioned in"
}

variable "machine_type" {
  type        = string
  description = "(Optional) Machine type for Cloud Build worker pool"
  default     = "e2-medium"
}
