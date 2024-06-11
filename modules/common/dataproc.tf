variable "project_id" {
  description = "The ID of the project where the resources will be created."
  type        = string
}

variable "region" {
  description = "The region where the resources will be created."
  type        = string
}

resource "google_dataproc_cluster" "cluster" {
  name       = "example-cluster"
  project    = var.project_id
  region     = var.region
  cluster_config {
    master_config {
      num_instances = 1
      machine_type  = "n1-standard-4"
    }
    worker_config {
      num_instances = 2
      machine_type  = "n1-standard-4"
    }
  }
}

output "dataproc_cluster_name" {
  value = google_dataproc_cluster.cluster.name
}
