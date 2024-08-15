locals {
  # https://cloud.google.com/sql/docs/mysql/logging#view_logs
  logging_flags = [
    {
      name  = "general_log"
      value = "on"
    },
    {
      name  = "log_output"
      value = "FILE"
    }
  ]
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "this" {
  project = var.project_id
  region  = var.region
  name    = "${var.prefix}-${var.name}-${random_id.db_name_suffix.hex}"

  database_version = var.database_version

  settings {
    tier              = var.tier
    availability_type = "REGIONAL"

    ip_configuration {
      private_network = var.vpc
      # Public IPv4
      ipv4_enabled = false
      ssl_mode     = "ENCRYPTED_ONLY"
    }

    # https://cloud.google.com/sql/docs/mysql/flags
    database_flags {
      name  = "cloudsql_iam_authentication"
      value = "on"
    }

    dynamic "database_flags" {
      for_each = var.general_logging ? local.logging_flags : []
      content {
        name  = lookup(database_flags.value, "name", null)
        value = lookup(database_flags.value, "value", null)
      }
    }

    dynamic "database_flags" {
      for_each = var.extra_flags
      content {
        name  = lookup(database_flags.value, "name", null)
        value = lookup(database_flags.value, "value", null)
      }
    }

    # MySQL HA non-replica instances need to have binary logging enabled
    backup_configuration {
      enabled            = true
      binary_log_enabled = true
    }
  }

  deletion_protection = var.deletion_protection
}
