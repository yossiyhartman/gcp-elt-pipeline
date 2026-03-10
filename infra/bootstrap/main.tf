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


locals {
  service_account_roles = [
    "roles/run.admin",
    "roles/storage.admin",
    "roles/cloudsql.admin",
    "roles/artifactregistry.admin"
  ]
  enable_api_list = [
    "iam.googleapis.com",
    "artifactregistry.googleapis.com",
    "run.googleapis.com",
    "sqladmin.googleapis.com"
  ]
}

# State Bucket

resource "google_storage_bucket" "terraform_state" {
  project  = "yossi-infra-ci-project"
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

# Enable APIs

resource "google_project_service" "enabled_apis" {
  project            = "yossi-infra-ci-project"
  for_each           = toset(local.enable_api_list)
  service            = each.key
  disable_on_destroy = false
}

# Service Account

resource "google_service_account" "terraform_sa" {
  project      = "yossi-infra-ci-project"
  account_id   = "terraform"
  display_name = "Terraform Service Account"
  description  = "This account will be used for the CI pipeline."
}

resource "google_project_iam_member" "sa_project_roles" {
  project  = "yossi-infra-ci-project"
  for_each = toset(local.service_account_roles)
  role     = each.value
  member   = "serviceAccount:${google_service_account.terraform_sa.email}"
}
