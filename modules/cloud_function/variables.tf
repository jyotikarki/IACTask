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



variable "pubsubname" {
  description = "The name of the GCS bucket to trigger the Cloud Function"
  type        = string
  default = "pubsub-11111113"
}

variable "functionname" {
  description = "The ID of your Google Cloud project"
  type        = string
  default = "itsme-1234-funct"
}

variable "source_archive_bucket" {
  description = "The ID of your Google Cloud project"
  type        = string
  default = "tffinalgcsbucket12345"
}

variable "source_archive_object" {
  description = "The ID of your Google Cloud project"
  type        = string
  default = "function.zip"
}

