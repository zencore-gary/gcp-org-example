variable "project_id" {
  type        = string
  description = "(Required) Project ID to provision the cluster"
}

variable "vpc" {
  type        = string
  description = "(Required) The VPC Network"
}

variable "subnets" {
  type        = map(any)
  description = "(Required) The subnetwork to deploy to"
}
