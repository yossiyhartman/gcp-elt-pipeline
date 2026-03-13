terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project = "yossi-infra-ci-project"
}

# State Bucket

resource "google_storage_bucket" "terraform_state" {
  name     = "yossi-infra-ci-project-terraform-state"
  location = "EU"

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}
