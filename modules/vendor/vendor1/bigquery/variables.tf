variable "project_id" {
  type        = string
}

variable "region" {
  type        = string
}

variable "dataset_id" {
  type        = string
}

variable "dataset_description" {
  type        = string
  default     = "An example BigQuery dataset"
}

variable "default_table_expiration_ms" {
  type        = number
  default     = null
}
variable "output_table_id" {
  description = "The table ID for the output table"
  type        = string
  default = "okok"
}