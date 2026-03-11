resource "google_sql_database_instance" "instance" {
  name             = var.instance-name
  region           = "europe-west4"
  database_version = "POSTGRES_17"

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_database" "db" {
  name       = var.db-name
  instance   = google_sql_database_instance.instance.name
  depends_on = [google_sql_database_instance.instance]
}
