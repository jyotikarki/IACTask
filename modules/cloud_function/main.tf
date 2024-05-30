resource "google_cloudfunctions_function" "function" {
  name        = var.functionname
  description = "Triggered by GCS when a CSV file is uploaded"
  runtime     = "python39"

  available_memory_mb   = 256
  source_archive_bucket = var.source_archive_bucket
  source_archive_object = var.source_archive_object
  entry_point           = "hello_gcs"

  event_trigger {
    event_type = "google.storage.object.finalize"
    resource   = var.source_archive_bucket
  }

  environment_variables = {
    PUBSUB_TOPIC = var.pubsubname
  }
}