variable "project_id" {
  type        = string
  description = "(Required) Project ID to provision the instance"
}

variable "prefix" {
  type        = string
  description = "(Required) The prefix e.g. dev/prod or blue/green"
}

variable "name" {
  type        = string
  description = "(Required) The name of the instance"
}

variable "region" {
  type        = string
  description = "(Required) The region the instance should be provisioned in"
}

variable "type" {
  type        = string
  description = "(Required) Instance type"
  default     = "e2-micro"
}

variable "network" {
  type        = string
  description = "(Required) The VPC Network to attach the instance to"
}

variable "subnetwork" {
  type        = string
  description = "(Required) The subnetwork to host the instance in"
}
