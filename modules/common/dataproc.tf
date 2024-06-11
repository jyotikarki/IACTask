resource "google_dataproc_cluster" "cluster" {
  name       = "example-cluster"
  project    = var.project_id
  region     = var.region
  cluster_config {
    master_config {
      num_instances = 1
      machine_type  = "n1-standard-2"  # Smaller machine type
    }
    worker_config {
      num_instances = 2
      machine_type  = "n1-standard-2"  # Smaller machine type
    }
  }
}


output "dataproc_cluster_name" {
  value = google_dataproc_cluster.cluster.name
}
