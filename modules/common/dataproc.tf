resource "google_dataproc_cluster" "cluster" {
  name   = "example-cluster"
  project = var.project_id
  region = var.region

  cluster_config {
    master_config {
      num_instances = 1
      machine_type  = "n1-standard-2"
      disk_config {
        boot_disk_size_gb = 50  # Adjust the size accordingly
      }
    }

    worker_config {
      num_instances = 2
      machine_type  = "n1-standard-2"
      disk_config {
        boot_disk_size_gb = 50  # Adjust the size accordingly
      }
    }
  }
}



output "dataproc_cluster_name" {
  value = google_dataproc_cluster.cluster.name
}
