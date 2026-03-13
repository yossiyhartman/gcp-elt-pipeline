resource "google_sql_database_instance" "instance" {
  name             = var.instance_name
  region           = "europe-west4"
  database_version = "POSTGRES_17"

  settings {
    tier = "db-f1-micro"
  }


  deletion_protection = false
}


# User
# #######

resource "google_secret_manager_secret" "dbuser" {
  secret_id = "db-user-secret"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "dbuser_data" {
  secret      = google_secret_manager_secret.dbuser.id
  secret_data = var.db_user
}

resource "google_secret_manager_secret_iam_member" "secretaccess_dbuser" {
  secret_id = google_secret_manager_secret.dbuser.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${var.service_account_email}"
}


# Password
# #######


resource "google_secret_manager_secret" "dbpass" {
  secret_id = "db-password-secret"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "dbpass_data" {
  secret      = google_secret_manager_secret.dbpass.id
  secret_data = var.db_password
}

resource "google_secret_manager_secret_iam_member" "secretaccess_dbpass" {
  secret_id = google_secret_manager_secret.dbpass.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${var.service_account_email}"
}


# Database name
# #######

resource "google_secret_manager_secret" "dbname" {
  secret_id = "db-name-secret"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "dbname_data" {
  secret      = google_secret_manager_secret.dbname.id
  secret_data = var.db_name
}

resource "google_secret_manager_secret_iam_member" "secretaccess_dbname" {
  secret_id = google_secret_manager_secret.dbname.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${var.service_account_email}"
}
