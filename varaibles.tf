variable "project_id" {
  description = "The project ID to deploy to"
  type        = string
}

variable "bucket_name" {
  description = "The name of the bucket to create"
  type        = string
}
variable "region" {
  default = "us-central1"
}

variable "location" {
  default = "US"
}
 

