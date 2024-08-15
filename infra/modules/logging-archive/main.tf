/* TODO - This module is not called yet */

resource "google_storage_bucket" "this" {
  project  = var.project_id
  location = var.location
  name     = var.name

  storage_class               = "ARCHIVE"
  force_destroy               = true
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  /* TODO - Error 400: Bucket's Versioning cannot be set for Bucket 'shared-logging-archive' that has retention policy

  versioning {
    enabled = true
  }
  */

  lifecycle_rule {
    condition {
      age = var.expiration_days
    }
    action {
      type = "Delete"
    }
  }

  retention_policy {
    is_locked        = var.lock
    retention_period = var.retention_days * 86400 # Convert days to seconds
  }

  labels = var.labels
}

# Creare a logging sink for audit logs to the logging bucket
resource "google_logging_folder_sink" "this" {
  name             = var.name
  description      = "Sink for folder to a logging archive bucket, including all children logs"
  folder           = var.folder_id
  destination      = "storage.googleapis.com/${google_storage_bucket.this.id}"
  include_children = true

  # By default - only store audit logs
  filter = coalesce(var.filter, "protoPayload.@type = type.googleapis.com/google.cloud.audit.AuditLog")

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

resource "google_storage_bucket_iam_member" "this" {
  bucket = google_storage_bucket.this.name
  role   = "roles/storage.objectCreator"
  member = google_logging_folder_sink.this.writer_identity
}
