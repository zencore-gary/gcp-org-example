/* Test topic, to use instead of the real Google provided one */

resource "google_pubsub_topic" "marketplace_backend" {
  name    = "${var.prefix}-${var.environment}-topic"
  project = module.project.project_id
}
