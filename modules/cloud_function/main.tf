provider "google" {
  project     = var.project_id
  region      = var.region

}

resource "google_storage_bucket" "function_bucket" {
  name          = var.bucket_name
  location      = var.region
  force_destroy = true
}

resource "google_storage_bucket" "trigger_bucket" {
  name          = var.trigger_bucket_name
  location      = var.region
  force_destroy = true
}

resource "google_storage_bucket_object" "function_zip" {
  name   = "function.zip"
  bucket = google_storage_bucket.function_bucket.name
  source = "${path.module}/cloud-function/function.zip"
}

resource "google_cloudfunctions_function" "function" {
  name        = "my-cloud-6"
  description = "My Cloud Function"
  runtime     = "python39"
  available_memory_mb   = 256
  source_archive_bucket = google_storage_bucket.function_bucket.name
  source_archive_object = google_storage_bucket_object.function_zip.name
  entry_point           = "hello_gcs"

  event_trigger {
    event_type = "google.storage.object.finalize"
    resource   = google_storage_bucket.trigger_bucket.name
  }

  environment_variables = {
    PROJECT_ID = var.project_id
  }

  depends_on = [google_storage_bucket_object.function_zip]
}

