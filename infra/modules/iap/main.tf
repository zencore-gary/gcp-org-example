locals {
  default_iap_members = [
    "domain:zencore.dev",
    "domain:blockapt.com",
    #"group:ops@zencore.dev",
    #"user:gbowers@zencore.dev",
    #"user:ddumas@zencore.dev",
  ]

  # Use default if IAP member list is not provided
  iap_members = toset(length(var.iap_members) == 0 ? local.default_iap_members : var.iap_members)
}

resource "google_iap_web_iam_member" "this" {
  for_each = local.iap_members

  project = var.project_id
  role    = "roles/iap.httpsResourceAccessor"
  member  = each.value

  condition {
    title       = "filter_host"
    description = "Filter request host"
    expression  = "request.host == \"${var.host}\""
  }
}
