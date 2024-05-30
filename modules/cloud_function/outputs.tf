output "cloud_function_name" {
  description = "The name of the deployed Cloud Function"
  value       = google_cloudfunctions_function.function.name
}

output "cloud_function_trigger_bucket" {
  description = "The name of the GCS bucket that triggers the Cloud Function"
  value       = google_storage_bucket.trigger_bucket.name
}