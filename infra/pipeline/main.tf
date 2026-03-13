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

module "enable_project_services" {
  source = "./modules/project_services"
}

module "service_account" {
  source       = "./modules/service_account"
  project_name = var.project_name
  depends_on   = [module.enable_project_services]
}

module "artifact_registry" {
  source           = "./modules/artifact_registry"
  artifact_repo_id = var.artifact_repo_id
  depends_on       = [module.enable_project_services]
}

module "blobstorage" {
  source      = "./modules/blobstorage"
  bucket_name = "yossi-data-bucket"
  depends_on  = [module.enable_project_services]
}

module "cloudsql" {
  source                = "./modules/cloudsql"
  instance_name         = var.instance_name
  db_name               = var.db_name
  db_user               = var.db_user
  db_password           = var.db_password
  service_account_email = module.service_account.service_account_email
  depends_on            = [module.enable_project_services, module.service_account]
}
