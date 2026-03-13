locals {
  service_account_roles = [
    "roles/storage.admin",
    # "roles/run.admin",
    # "roles/cloudsql.admin",
    # "roles/artifactregistry.admin",
  ]
}


resource "google_service_account" "terraform_sa" {
  account_id   = "terraform"
  display_name = "Terraform Service Account"
  description  = "This account will be used for the CI pipeline."
}

resource "google_project_iam_member" "sa_project_roles" {
  project  = var.project_name
  for_each = toset(local.service_account_roles)
  role     = each.value
  member   = "serviceAccount:${google_service_account.terraform_sa.email}"
}

output "service_account_email" {
  value = google_service_account.terraform_sa.email
}
