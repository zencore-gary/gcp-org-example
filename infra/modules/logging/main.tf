# Creare a logging sink for audit logs from the folder to the target logging bucket
resource "google_logging_folder_sink" "this" {
  name             = var.name
  description      = "Sink for folder to a logging bucket, including all children logs"
  folder           = var.folder_id
  destination      = "logging.googleapis.com/projects/${var.project_id}/locations/${var.location}/buckets/${var.bucket_id}"
  include_children = true

  filter = var.filter

  dynamic "exclusions" {
    for_each = concat(local.default_exclusions, var.exclusions)
    content {
      name        = exclusions.value.name
      description = exclusions.value.description
      filter      = exclusions.value.filter
      disabled    = false
    }
  }
}

# Allow each sink's service account to write logs into the audit logs project
resource "google_project_iam_member" "this" {
  project = var.project_id
  role    = "roles/logging.bucketWriter"
  member  = google_logging_folder_sink.this.writer_identity

  depends_on = [google_logging_folder_sink.this]
}
