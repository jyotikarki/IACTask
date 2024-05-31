variable "project_id" {
  description = "The ID of your Google Cloud project"
  type        = string
  default     = "itsme-1234"
} 
variable "bucket_name" {
  description = "The name of the GCS bucket"
  type        = string
  default = "tffinalgcsbucket123456"
 
}

variable "region" {
  description = "The location of the GCS bucket"
  type        = string
  default     = "us-central1"
}

variable "force_destroy" {
  description = "Whether to force destroy the bucket"
  type        = bool
  default     = false
}

variable "storage_class" {
  description = "The storage class of the bucket"
  type        = string
  default     = "STANDARD"
}

variable "versioning_enabled" {
  description = "Enable versioning for the bucket"
  type        = bool
  default     = false
}

variable "uniform_bucket_level_access" {
  description = "Enable uniform bucket-level access"
  type        = bool
  default     = true
}


