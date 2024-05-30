output "dataset_id" {
  description = "The ID of the created dataset."
  value       = google_bigquery_dataset.example_dataset.dataset_id
}

output "table_id" {
  description = "The ID of the created table."
  value       = google_bigquery_table.example_table.table_id
}
