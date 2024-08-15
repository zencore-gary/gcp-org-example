locals {
  location           = var.regional ? var.region : var.zones[0]
  region             = var.regional ? var.region : join("-", slice(split("-", var.zones[0]), 0, 2))
  network_project_id = var.network_project_id != "" ? var.network_project_id : var.project_id

  registry_projects_list = length(var.registry_project_ids) == 0 ? [var.project_id] : var.registry_project_ids

  node_oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
}
