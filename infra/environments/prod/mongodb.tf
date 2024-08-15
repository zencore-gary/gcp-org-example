### MongoDB credentials

locals {
  mongodb_users = ["admin", "master", "logger", "search", "graphs"]
}

resource "random_password" "mongodb_users" {
  for_each = toset(local.mongodb_users)

  length      = 40
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
  min_special = 1
}

resource "google_secret_manager_secret" "mongodb_users" {
  for_each = toset(local.mongodb_users)

  project   = module.project.project_id
  secret_id = "mongodb-${each.value}"

  labels = {
    component = "mongodb"
    env       = var.environment
    terraform = "true"
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "mongodb_users" {
  for_each = toset(local.mongodb_users)

  secret      = google_secret_manager_secret.mongodb_users[each.value].id
  secret_data = random_password.mongodb_users[each.value].result
}
