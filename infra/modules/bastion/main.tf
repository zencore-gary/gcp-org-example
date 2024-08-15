data "google_compute_zones" "this" {
  project = var.project_id
  region  = var.region
}

resource "random_shuffle" "google_compute_zone" {
  input        = data.google_compute_zones.this.names
  result_count = 1
}

resource "google_service_account" "bastion" {
  project      = var.project_id
  account_id   = "${var.prefix}-${var.name}-bastion"
  display_name = "${var.prefix}-${var.name}-bastion"
}

resource "google_compute_instance" "this" {
  project      = var.project_id
  name         = "${var.prefix}-${var.name}-bastion"
  machine_type = var.type
  zone         = random_shuffle.google_compute_zone.result[0]

  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
  }

  service_account {
    email  = google_service_account.bastion.email
    scopes = ["cloud-platform"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_vtpm                 = true
  }

  metadata_startup_script = <<EOF
cd /tmp
apt update -y
apt install -y google-osconfig-agent google-cloud-cli-gke-gcloud-auth-plugin kubectl curl git jq nano vim wget
curl -fsSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
bash add-google-cloud-ops-agent-repo.sh --also-install
rm add-google-cloud-ops-agent-repo.sh
curl -fsSLO https://github.com/argoproj/argo-cd/releases/download/v2.10.12/argocd-linux-amd64
install -m 755 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64
curl -fsSLO https://get.helm.sh/helm-v3.15.2-linux-amd64.tar.gz
tar -xvf helm-v3.15.2-linux-amd64.tar.gz --strip-components=1 --totals linux-amd64/helm
install -m 755 helm /usr/local/bin/helm
rm helm
EOF

  metadata = {
    block-project-ssh-keys = true
  }

  lifecycle {
    ignore_changes = [
      metadata,
      metadata_startup_script
    ]
  }
}

# Add admin access to Kubernetes API

resource "google_project_iam_member" "roles_container_clusteradmin" {
  project = var.project_id
  role    = "roles/container.clusterAdmin"
  member  = google_service_account.bastion.member
}

resource "google_project_iam_member" "roles_container_containeradmin" {
  project = var.project_id
  role    = "roles/container.admin"
  member  = google_service_account.bastion.member
}

resource "google_project_iam_member" "roles_metricswriter" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = google_service_account.bastion.member
}

resource "google_project_iam_member" "roles_logswriter" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = google_service_account.bastion.member
}
