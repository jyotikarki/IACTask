provider "google" {
  project     = var.project_id
  region      = var.region
 
}

resource "google_bigquery_dataset" "example_dataset" {
  dataset_id                  = var.dataset_id
  location                    = var.region
  default_table_expiration_ms = var.default_table_expiration_ms
  description                 = var.dataset_description
}

resource "google_bigquery_table" "example_table" {
  dataset_id = google_bigquery_dataset.example_dataset.dataset_id
  table_id   = var.table_id

  schema = <<EOF
[
  {
    "name": "column1",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "Description of column1"
  },
  {
    "name": "column2",
    "type": "INTEGER",
    "mode": "NULLABLE",
    "description": "Description of column2"
  }
 
]
EOF

  time_partitioning {
    type = "DAY"
  }
}