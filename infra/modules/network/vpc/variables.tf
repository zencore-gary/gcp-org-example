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
