resource "google_project_iam_member" "mp_iam_editor" {
  project = module.project.project_id
  role    = "roles/editor"
  member  = "group:cloud-commerce-marketplace-onboarding@twosync-src.google.com"
}

resource "google_project_iam_member" "mp_iam_smadmin" {
  project = module.project.project_id
  role    = "roles/servicemanagement.admin"
  member  = "group:cloud-commerce-marketplace-onboarding@twosync-src.google.com"
}

resource "google_project_iam_member" "mp_iam_config" {
  project = module.project.project_id
  role    = "roles/servicemanagement.configEditor"
  member  = "serviceAccount:cloud-commerce-producer@system.gserviceaccount.com"
}

resource "google_project_iam_member" "mp_iam_proc_serviceconsumer" {
  project = module.project.project_id
  role    = "roles/servicemanagement.admin"
  member  = "serviceAccount:cloud-commerce-procurement@system.gserviceaccount.com"
}
