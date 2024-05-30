variable "project_id" {
  description = "The ID of your Google Cloud project"
  type        = string
  default     = "itsme-1234"
}

variable "region" {
  description = "The region for the BigQuery dataset"
  type        = string
  default     = "US"
}

variable "dataset_id" {
  description = "The ID of the BigQuery dataset"
  type        = string
  default     = "finalllyyyyyy"
}

variable "dataset_description" {
  description = "The description of the BigQuery dataset"
  type        = string
  default     = "An example BigQuery dataset"
}

variable "default_table_expiration_ms" {
  description = "Default expiration time for tables in the dataset, in milliseconds"
  type        = number
  default     = null
}

variable "table_id" {
  description = "The ID of the BigQuery table"
  type        = string
  default     = "mylasttttableee"
}