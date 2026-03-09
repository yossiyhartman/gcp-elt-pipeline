data "google_artifact_registry_locations" "available" {}

resource "google_artifact_registry_repository" "artifact-repo" {
  repository_id = var.artifact-repo-id
  description   = ""
  format        = "DOCKER"
  location      = data.google_artifact_registry_locations.available.locations[0]
}
