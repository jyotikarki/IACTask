# Infrastructure as Code (IaC) Task Documentation

This document outlines the steps to set up and deploy Google Cloud Platform (GCP) resources using Terraform modules. The resources include Google Cloud Storage (GCS), Cloud Functions, BigQuery, and a VPC network. The deployment process is automated using GitHub Actions and authenticated with GCP via OpenID Connect (OIDC).

## Table of Contents
1. Prerequisites
2. Project Structure
3. Configuration
4. Terraform Modules
    - GCS Module
    - Cloud Function Module
    - BigQuery Module
    - VPC Module
5. Main Terraform Configuration
6. GitHub Actions Workflow
7. Commands
8. Conclusion

## 1. Prerequisites

Ensure you have the following prerequisites:
- Google Cloud SDK installed and authenticated
- Terraform installed
- GitHub account
- GCP project with necessary APIs enabled
- Service account with necessary permissions
- JSON key file for the service account

## 2. Project Structure

The repository is structured as follows:

```
.
├── .github
│   └── workflows
│       └── main.yml
├── config.json
├── main.tf
├── modules
│   ├── bigquery
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── cloud_function
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── gcs
│   │   ├── main.tf
│   │   └── variables.tf
│   └── vpc
│       ├── main.tf
│       └── variables.tf
├── outputs.tf
└── variables.tf
```

## 3. Configuration

Create a `config.json` file to define your configuration values:

```json
{
  "project_id": "your-project-id",
  "credentials_path": "/path/to/your/credentials.json",
  "region": "us-central1",
  "gcs_bucket_name": "your-gcs-bucket-name",
  "location": "US",
  "function_name": "your-function-name",
  "dataset_id": "your-dataset-id",
  "table_id": "your-table-id",
  "table_schema": [
    {
      "name": "name",
      "type": "STRING",
      "mode": "REQUIRED"
    },
    {
      "name": "age",
      "type": "INTEGER",
      "mode": "NULLABLE"
    }
  ],
  "network_name": "your-network-name",
  "subnet_name": "your-subnet-name",
  "subnet_cidr": "10.0.0.0/24"
}
```

## 4. Terraform Modules

### GCS Module

`modules/gcs/main.tf`:

```hcl
resource "google_storage_bucket" "bucket" {
  name                        = var.gcs_bucket_name
  location                    = var.location
  force_destroy               = true
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}
```

`modules/gcs/variables.tf`:

```hcl
variable "gcs_bucket_name" {}
variable "location" {}
```

### Cloud Function Module

`modules/cloud_function/main.tf`:

```hcl
resource "google_cloudfunctions_function" "function" {
  name        = var.function_name
  description = "My Cloud Function"
  runtime     = "python39"

  available_memory_mb   = 256
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.object.name
  entry_point           = "hello_world"

  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = google_pubsub_topic.topic.id
  }
}
```

`modules/cloud_function/variables.tf`:

```hcl
variable "function_name" {}
variable "project_id" {}
variable "credentials_path" {}
```

### BigQuery Module

`modules/bigquery/main.tf`:

```hcl
resource "google_bigquery_dataset" "dataset" {
  dataset_id = var.dataset_id
  location   = var.location
}

resource "google_bigquery_table" "table" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = var.table_id

  schema = jsonencode(var.table_schema)
}
```

`modules/bigquery/variables.tf`:

```hcl
variable "dataset_id" {}
variable "table_id" {}
variable "table_schema" {
  type = list(object({
    name = string
    type = string
    mode = string
  }))
}
variable "location" {}
```

### VPC Module

`modules/vpc/main.tf`:

```hcl
resource "google_compute_network" "vpc_network" {
  name = var.network_name
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  network       = google_compute_network.vpc_network.id
  region        = var.region
}
```

`modules/vpc/variables.tf`:

```hcl
variable "network_name" {}
variable "subnet_name" {}
variable "subnet_cidr" {}
variable "region" {}
```

## 5. Main Terraform Configuration

`main.tf`:

```hcl
provider "google" {
  credentials = file(var.credentials_path)
  project     = var.project_id
  region      = var.region
}

module "gcs" {
  source           = "./modules/gcs"
  gcs_bucket_name  = var.gcs_bucket_name
  location         = var.location
}

module "cloud_function" {
  source           = "./modules/cloud_function"
  function_name    = var.function_name
  project_id       = var.project_id
  credentials_path = var.credentials_path
}

module "bigquery" {
  source         = "./modules/bigquery"
  dataset_id     = var.dataset_id
  table_id       = var.table_id
  table_schema   = var.table_schema
  location       = var.location
}

module "vpc" {
  source       = "./modules/vpc"
  network_name = var.network_name
  subnet_name  = var.subnet_name
  subnet_cidr  = var.subnet_cidr
  region       = var.region
}
```

`variables.tf`:

```hcl
variable "project_id" {}
variable "credentials_path" {}
variable "region" {}
variable "gcs_bucket_name" {}
variable "location" {}
variable "function_name" {}
variable "dataset_id" {}
variable "table_id" {}
variable "table_schema" {
  type = list(object({
    name = string
    type = string
    mode = string
  }))
}
variable "network_name" {}
variable "subnet_name" {}
variable "subnet_cidr" {}
```

## 6. GitHub Actions Workflow

`.github/workflows/main.yml`:

```yaml
name: Terraform

on:
  push:
    branches:
      - main

jobs:
  terraform:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout repository
      uses: actions/checkout@v2

    - name: Set up Terraform
      uses: hashicorp/setup-terraform@v1

    - name: Terraform Init
      run: terraform init

    - name: Terraform Plan
      run: terraform plan -out tfplan

    - name: Terraform Apply
      run: terraform apply -auto-approve tfplan
```

## 7. Commands

Initialize Terraform:

```sh
terraform init
```

Validate the configuration:

```sh
terraform validate
```

Generate and show the execution plan:

```sh
terraform plan -out tfplan
```

Apply the changes:

```sh
terraform apply -auto-approve tfplan
```

## 8. Conclusion

This document provides a detailed guide to set up and deploy GCP resources using Terraform and GitHub Actions. By following these steps, you can automate your infrastructure deployments and ensure consistency across your environments.

--- 







