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

data "google_kms_key_ring" "key_ring" {
  name = var.keyringInfo.keyringName
  location = var.projectInfo.region
}

resource "google_kms_crypto_key" "crypto_key" {
  name = var.keyInfo.keyName
  key_ring = data.google_kms_key_ring.key_ring.id

  depends_on = [
    data.google_kms_key_ring.key_ring
  ]
}

resource "google_kms_crypto_key_iam_binding" "crypto_key_binding" {  
  crypto_key_id = google_kms_crypto_key.crypto_key.id
  role = var.keyInfo.role
  members = [ 
    "serviceAccount:${data.google_service_account.service-account.email}" 
  ]

  depends_on = [
    google_kms_crypto_key.crypto_key
  ]
}