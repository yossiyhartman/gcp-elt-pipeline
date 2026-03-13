resource "google_artifact_registry_repository" "artifact-repo" {
  repository_id = var.artifact_repo_id
  description   = ""
  format        = "DOCKER"
  location      = "europe-west4"


}
