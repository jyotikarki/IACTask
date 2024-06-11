resource "google_bigquery_table" "output_table" {
  dataset_id = var.dataset_id
  table_id   = var.output_table_id
  project    = var.project_id

  schema = file("${path.module}/schemas/output_table_schema.json")

  time_partitioning {
    type = "DAY"
  }
}
