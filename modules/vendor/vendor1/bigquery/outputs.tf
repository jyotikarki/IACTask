output "dataset_id" {
  description = "The ID of the created dataset."
  value       = google_bigquery_dataset.example_dataset.dataset_id
}

output "output_table_id" {
  value = google_bigquery_table.output_table.table_id
}
