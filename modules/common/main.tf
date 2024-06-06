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
  source                = "./modules/common"
  service_account_email = "user:${var.service_account_email}"
}

module "gcs" {
  for_each = local.vendor_data

  source = "./modules/${each.key}/gcs"

  project_id  = each.value.project_id
  region      = each.value.region
  bucket_name = each.value.bucket_name
}

module "bigquery" {
  for_each = local.vendor_data

  source = "./modules/${each.key}/bigquery"

  project_id  = each.value.project_id
  region      = each.value.region
  dataset_id  = each.value.dataset_id
}

module "cloud_function" {
  for_each = local.vendor_data

  source = "./modules/${each.key}/cloud_function"

  project_id    = each.value.project_id
  region        = each.value.region
  function_name = each.value.function_name
  entry_point   = each.value.entry_point
  bucket_name   = each.value.bucket_name
  pubsub_name   = each.value.pubsub_name
}

module "pubsub" {
  for_each = local.vendor_data

  source = "./modules/${each.key}/pubsub"

  project_id  = each.value.project_id
  region      = each.value.region
  topic_name  = each.value.topic_name
}

resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public_subnet" {
  count                    = length(var.public_subnets)
  name                     = var.public_subnets[count.index].name
  ip_cidr_range            = var.public_subnets[count.index].cidr
  region                   = var.region
  network                  = google_compute_network.vpc_network.self_link
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "private_subnet" {
  count                    = length(var.private_subnets)
  name                     = var.private_subnets[count.index].name
  ip_cidr_range            = var.private_subnets[count.index].cidr
  region                   = var.region
  network                  = google_compute_network.vpc_network.self_link
  private_ip_google_access = false
}
