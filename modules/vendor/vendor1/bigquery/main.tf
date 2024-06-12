
resource "google_bigquery_dataset" "example_dataset" {
  dataset_id                  = var.dataset_id
  location                   = var.region
  default_table_expiration_ms = var.default_table_expiration_ms
  description                 = var.dataset_description
}

resource "google_bigquery_table" "output_table" {
  dataset_id = var.dataset_id
  table_id   = var.output_table_id
  project    = var.project_id

  schema = file("${path.module}/schemas.yaml")

  time_partitioning {
    type = "DAY"
  }
}
