output "name" {
  value       = google_container_cluster.cluster.name
  description = "GKE cluster name"
}

output "location" {
  value       = google_container_cluster.cluster.location
  description = "GKE cluster location"
}

output "sa" {
  value       = google_service_account.cluster.email
  description = "GKE cluster service account"
}

output "node_pools" {
  value       = [for n in google_container_node_pool.node_pools : n.name]
  description = "GKE cluster node pools"
}

output "regional" {
  value       = var.regional
  description = "GKE cluster is regional with multiple masters spread across zones in the region"
}

output "zonal" {
  value       = !var.regional
  description = "GKE cluster is zonal with a single master"
}
