variable "project_id" {
  description = "The ID of your Google Cloud project"
  type        = string
  default = "itsme-1234"
}

variable "region" {
  description = "The region for the Cloud Function"
  type        = string
  default     = "us-central1"
}

variable "bucket_name" {
  description = "The name of the GCS bucket for Cloud Function deployment"
  type        = string
  default = "lastandfinalbucket32"
}

variable "trigger_bucket_name" {
  description = "The name of the GCS bucket to trigger the Cloud Function"
  type        = string
  default = "lastandfinalbucket32trigger"
}

