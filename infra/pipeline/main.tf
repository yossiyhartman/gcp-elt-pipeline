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

module "artifact-registry" {
  source           = "./modules/artifactregistry"
  artifact-repo-id = "yossi-artifact-repo"
}

module "blobstorage" {
  source      = "./modules/blobstorage"
  bucket-name = "yossi-data-bucket"
}

module "cloudsql" {
  source        = "./modules/cloudsql"
  instance-name = "yossi-db-instance"
  db-name       = "yossi-db"
}
