provider "google" {
  project = var.project_id
  region  = var.region
}


resource "google_pubsub_topic" "topic" {
  name = var.pubsub_topic
}
