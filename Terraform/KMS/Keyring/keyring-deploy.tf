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

resource "google_kms_key_ring" "key_ring" {
  name = var.keyringInfo.keyringName
  location = var.projectInfo.region
}

resource "google_kms_key_ring_iam_binding" "key_ring_binding" {  
  key_ring_id = google_kms_key_ring.key_ring.id  
  role = var.keyringInfo.role
  members = [ 
    "serviceAccount:${data.google_service_account.service-account.email}" 
  ]

  depends_on = [
    google_kms_key_ring.key_ring
  ]
}