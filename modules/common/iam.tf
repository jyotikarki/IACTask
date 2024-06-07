resource "google_project_iam_binding" "viewer_role" {
  project = var.project_id
  role    = "roles/viewer"

  members = [
    "serviceAccount:${var.service_account_email}"
  ]
}

resource "google_project_iam_binding" "editor_role" {
  project = var.project_id
  role    = "roles/editor"

  members = [
    "serviceAccount:${var.service_account_email}"
  ]
}

output "viewer_role_binding" {
  value = google_project_iam_binding.viewer_role
}

output "editor_role_binding" {
  value = google_project_iam_binding.editor_role
}
