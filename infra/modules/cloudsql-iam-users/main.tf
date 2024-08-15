resource "google_sql_user" "mysql_users" {
  for_each = { for user in var.users : user.name => user }

  project  = var.project_id
  instance = var.instance
  name     = google_service_account.mysql_users[each.key].email
  type     = "CLOUD_IAM_SERVICE_ACCOUNT"
}

resource "google_service_account" "mysql_users" {
  for_each = { for user in var.users : user.name => user }

  project      = var.project_id
  account_id   = "${var.prefix}-${var.name}-${each.key}"
  display_name = "${var.prefix}-${var.name}-${each.key}"
}

resource "google_project_iam_member" "iam_wiu" {
  for_each = { for user in var.users : user.name => user }

  project = var.project_id
  role    = "roles/iam.workloadIdentityUser"
  member  = "serviceAccount:${var.project_id}.svc.id.goog[${each.value.path}]"
}

resource "google_project_iam_member" "cloudsql_instanceuser" {
  for_each = { for user in var.users : user.name => user }

  project = var.project_id
  role    = "roles/cloudsql.instanceUser"
  member  = "serviceAccount:${google_service_account.mysql_users[each.key].email}"
}

resource "google_project_iam_member" "cloudsql_client" {
  for_each = { for user in var.users : user.name => user }

  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.mysql_users[each.key].email}"
}
