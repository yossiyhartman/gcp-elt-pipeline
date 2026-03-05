terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project = var.project_name
}


locals {
  service_account_roles = [
    "roles/run.admin",
    "roles/storage.admin",
    "roles/cloudsql.admin",
    "roles/artifactregistry.admin"
  ]
}

# State Bucket

resource "google_storage_bucket" "terraform_state" {
  project  = var.project_name
  name     = "${var.project_name}-terraform-state"
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
  project            = var.project_name
  for_each           = toset(var.enable_api_list)
  service            = each.key
  disable_on_destroy = false
}

# Service Account

resource "google_service_account" "terraform_sa" {
  project      = var.project_name
  account_id   = var.service_account_id
  display_name = "Terraform Service Account"
  description  = "This account will be used for the CI pipeline."
}

# Service Account Roles

resource "google_service_account_iam_member" "sa_account_user" {
  service_account_id = google_service_account.terraform_sa.name
  role               = "roles/iam.serviceAccountUser"
  member             = "user:${var.personal_account}"
}

resource "google_project_iam_member" "sa_project_roles" {
  project  = var.project_name
  for_each = toset(local.service_account_roles)
  role     = each.value
  member   = "serviceAccount:${google_service_account.terraform_sa.email}"
}
