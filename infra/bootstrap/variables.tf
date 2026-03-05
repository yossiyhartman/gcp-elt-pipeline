variable "personal_account" {
  description = "My personal gcp account"
  type        = string
  sensitive   = true
}

variable "project_name" {
  description = "Name of the GCP Project"
  type        = string
}

variable "enable_api_list" {
  description = "The list of apis necessary for the project"
  type        = list(string)
  default = [
    "iam.googleapis.com",
    "artifactregistry.googleapis.com",
    "run.googleapis.com",
    "sqladmin.googleapis.com"
  ]
}

variable "service_account_id" {
  description = "id of the service account"
  type        = string
}
