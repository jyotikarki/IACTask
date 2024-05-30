provider "google" {
  project = var.project_id
  region  = var.location
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


