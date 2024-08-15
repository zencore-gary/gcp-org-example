resource "random_password" "mysql_admin" {
  length      = 40
  min_lower   = 1
  min_numeric = 1
  min_upper   = 1
  min_special = 1
}

resource "google_secret_manager_secret" "mysql_admin" {
  project   = var.project_id
  secret_id = google_sql_database_instance.this.name

  labels = {
    component = "mysql"
    terraform = "true"
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "mysql_admin" {
  secret      = google_secret_manager_secret.mysql_admin.id
  secret_data = random_password.mysql_admin.result
}

resource "google_sql_user" "mysql_admin" {
  project  = var.project_id
  instance = google_sql_database_instance.this.name
  name     = google_sql_database_instance.this.name
  type     = "BUILT_IN"
  password = random_password.mysql_admin.result
  # Connection only possible using CloudSQL proxy
  host = "cloudsqlproxy~%"
}

resource "google_service_account" "mysql_admin" {
  project      = var.project_id
  account_id   = "${var.prefix}-${var.name}-admin"
  display_name = "${var.prefix}-${var.name}-admin"
}

resource "google_project_iam_member" "iam_wiu" {
  project = var.project_id
  member  = "serviceAccount:${var.project_id}.svc.id.goog[${var.path}]"
  role    = "roles/iam.workloadIdentityUser"
}

resource "google_project_iam_member" "cloudsql_admin" {
  project = var.project_id
  member  = "serviceAccount:${google_service_account.mysql_admin.email}"
  role    = "roles/cloudsql.admin"
}
