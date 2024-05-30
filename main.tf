provider "google" {
  project = var.project_id
  region  = var.region
}  

resource "google_storage_bucket" "bucket" {
  name          = var.bucket_name
  location      = var.location
  force_destroy = true
}
module "gcs" {
  source  = "./modules/gcs"
}

module "cloud_function" {
   source  = "./modules/cloud_function"
}


module "bigquery" {
  source      = "./modules/bigquery"
}


