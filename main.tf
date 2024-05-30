provider "google" {
  project = var.project_id
  region  = var.location
}  


module "gcs" {
  source  = "./modules/gcs"
}

module "cloud_function" {
   source  = "./modules/cloud_function"
   depends_on = [module.bigquery]
}


module "bigquery" {
  source      = "./modules/bigquery"
  depends_on = [module.pubsub]
}

module "pubsub" {
  source      = "./modules/pubsub"
  depends_on = [module.gcs]
}

module "common" {
  source      = "./modules/common"
}



