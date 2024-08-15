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

variable "description" {
  type        = string
  description = "The description of the cluster"
  default     = ""
}

variable "release_channel" {
  type        = string
  description = "GKE Release channel."
  default     = "REGULAR"
}

variable "deletion_protection" {
  type        = bool
  description = "Enable or Disable deletion protection on the cluster"
  default     = false
}

variable "autopilot" {
  type        = bool
  description = "Enable autopilot mode (default is false)"
  default     = false
}

variable "regional" {
  type        = bool
  description = "Regional cluster (default is true)"
  default     = true
}

variable "region" {
  type        = string
  description = "The region to host the cluster in"
  default     = null
}

variable "zones" {
  type        = list(string)
  description = "The zones to host the cluster in (optional if regional cluster / required if zonal)"
  default     = []
}

variable "network" {
  type        = string
  description = "(Required) The VPC Network to attach the cluster to"
}

variable "network_project_id" {
  type        = string
  description = "The project ID of the shared VPC's host (for shared vpc support)"
  default     = ""
}

variable "subnetwork" {
  type        = string
  description = "(Required) The subnetwork to host the cluster in"
}

variable "stack_type" {
  type        = string
  description = "The stack type to use for this cluster. Either `IPV4` or `IPV4_IPV6`. Defaults to `IPV4`."
  default     = "IPV4"
}

variable "registry_project_ids" {
  type        = list(any)
  description = "Projects holding Google Container Registries. If empty, we use the cluster project."
  default     = []
}

variable "ip_range_pods" {
  type        = string
  description = "IPv4 CIDR for Kubernetes pods"
}

variable "ip_range_services" {
  type        = string
  description = "IPv4 CIDR for Kubernetes services"
}

variable "enable_cost_allocation" {
  type        = bool
  description = "Enables Cost Allocation Feature and the cluster name and namespace of your GKE workloads appear in the labels field of the billing export to BigQuery"
  default     = false
}

variable "labels" {
  type = object({
    env     = string
    purpose = string
    owner   = string
  })
  description = "Required labels for resources"
}

