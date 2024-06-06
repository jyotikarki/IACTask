module "gcs" {
  source = "../../modules/vendor/vendor1/gcs"
  project_id = var.project_id
  region = var.region
  vpc_name = var.vpc_name
  vpc_cidr_block = var.vpc_cidr_block
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  service_account_email = var.service_account_email
}

module "bigquery" {
  source = "../../modules/vendor/vendor1/bigquery"
  project_id = var.project_id
  region = var.region
  service_account_email = var.service_account_email
}

module "cloud_function" {
  source = "../../modules/vendor/vendor1/cloud_function"
  project_id = var.project_id
  region = var.region
  service_account_email = var.service_account_email
}

module "pubsub" {
  source = "../../modules/vendor/vendor1/pubsub"
  project_id = var.project_id
  region = var.region
  service_account_email = var.service_account_email
}
