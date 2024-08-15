resource "random_id" "postfix" {
  byte_length = 4
}

resource "google_cloudbuild_worker_pool" "this" {
  project  = var.project_id
  location = var.region
  name     = "${var.prefix}-${var.name}-${random_id.postfix.hex}"

  worker_config {
    disk_size_gb   = 100
    machine_type   = var.machine_type
    no_external_ip = var.worker_pool_no_external_ip
  }

  network_config {
    peered_network = var.network_name
  }
}

# TODO - Move repositories and triggers to Terraform code

/*
resource "google_cloudbuild_trigger" "docker" {
  project  = var.project_id
  location = var.region

  name     = "blockaptv9"
  filename = "cloudbuild.yaml"

  service_account = google_service_account.cloudbuild_worker_pool.id

  repository_event_config {
    repository = ""

    push {
      branch = "^ddumas/pack-master-service$"
    }
  }

  included_files = ["master/**"]
}
*/
