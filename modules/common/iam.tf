variable "project_id" {
  description = "The ID of the project where the resources will be created."
  type        = string
}

variable "region" {
  description = "The region where the resources will be created."
  type        = string
}

variable "service_account_email" {
  description = "The email of the service account to which the IAM roles will be assigned."
  type        = string
}

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
