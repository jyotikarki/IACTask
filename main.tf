provider "google" {
  project = var.project_id
  region  = var.region
}  

resource "google_storage_bucket" "bucket" {
  name          = var.bucket_name
  location      = var.location
  force_destroy = true
}

