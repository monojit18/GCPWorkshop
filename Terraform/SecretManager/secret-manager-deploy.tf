terraform {
  backend "gcs" {}
}

provider "google" {
    project = var.projectInfo.project
    region = var.projectInfo.region
    zone = var.projectInfo.zone
}

data "google_service_account" "service-account" {
  account_id = var.projectInfo.serviceAccount
}

resource "google_secret_manager_secret" "secret_manager" {
  secret_id = var.secretInfo.secretName
  replication {
    automatic = var.secretInfo.automatic
  }
}

resource "google_secret_manager_secret_version" "secret_manager_v10" {
  secret = google_secret_manager_secret.secret_manager.id
  secret_data = "hello secret:v10"

  depends_on = [
    google_secret_manager_secret.secret_manager
  ]
}

resource "google_secret_manager_secret_version" "secret_manager_v11" {
  secret = google_secret_manager_secret.secret_manager.id
  secret_data = "hello secret:v11"

  depends_on = [
    google_secret_manager_secret.secret_manager,
    google_secret_manager_secret_version.secret_manager_v10
  ]
}

resource "google_secret_manager_secret_iam_binding" "secret_manager_binding" {
  project = var.projectInfo.project
  secret_id = google_secret_manager_secret.secret_manager.id  
  role = var.secretInfo.role
  members = [ 
    "serviceAccount:${data.google_service_account.service-account.email}" 
  ]

  depends_on = [
    google_secret_manager_secret.secret_manager
  ]
}