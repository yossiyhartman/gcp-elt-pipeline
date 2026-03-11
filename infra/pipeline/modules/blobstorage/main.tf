resource "google_storage_bucket" "data_bucket" {
  name     = var.bucket-name
  location = "EU"

  uniform_bucket_level_access = true
}
