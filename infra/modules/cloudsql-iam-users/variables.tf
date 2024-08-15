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
  description = "(Required) The name of resources"
}

variable "instance" {
  type        = string
  description = "(Required) Target CloudSQL instance"
}

variable "users" {
  type        = list(any)
  description = "(Required)  List of CloudSQL IAM users to create"
}
