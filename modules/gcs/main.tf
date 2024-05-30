provider "google" {
  project = var.project_id
  region  = var.region
}
resource "google_storage_bucket" "bucket" {
  name          = var.bucket_name
  location      = var.region
  force_destroy = var.force_destroy
  storage_class = var.storage_class

  versioning {
    enabled = var.versioning_enabled
  }

  uniform_bucket_level_access = var.uniform_bucket_level_access
}

data "archive_file" "function_archive" {
  type        = "zip"
  source_dir  = "${path.module}/function-source"
  output_path = "${path.module}/function.zip"
}

resource "google_storage_bucket_object" "function_zip" {
  name   = "function.zip"
  bucket = google_storage_bucket.bucket.name
  source = data.archive_file.function_archive.output_path
}

