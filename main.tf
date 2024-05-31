provider "google" {
  project = var.project_id
  region  = var.region
}  


terraform {
  backend "gcs" {
    bucket  = "terraform-remote-backend-bucket"
    prefix  = "terraform/state"
  }
}

locals {
  vendor_data = { for vendor, path in var.vendor_configs : 
    vendor => jsondecode(file(path))
  }
}

module "common" {
  source      = "./modules/common"
}

module "gcs" {
  for_each = local.vendor_data

  source = "./modules/${each.key}/gcs"

  project_id = each.value.project_id
  region     = each.value.region
  bucket_name = each.value.dataset_id
}

module "bigquery" {
  for_each = local.vendor_data

  source = "./modules/${each.key}/bigquery"

  project_id = each.value.project_id
  region     = each.value.region
  dataset_id = each.value.dataset_id
}

module "cloud_function" {
  for_each = local.vendor_data

  source = "./modules/${each.key}/cloud_function"

  project_id             = each.value.project_id
  region                 = each.value.region
  functionname          = each.value.functionname
  entry_point            = each.value.entry_point
  bucket_name          = each.value.bucket_name
  pubsubname           = each.value.pubsubname
}

module "pubsub" {
  for_each = local.vendor_data

  source = "./modules/${each.key}/gcs"

  project_id = each.value.project_id
  region     = each.value.region
  bucket_name = each.value.bucket_name
}




