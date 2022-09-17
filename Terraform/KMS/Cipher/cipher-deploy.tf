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

data "google_secret_manager_secret_version" "secret_version" {
  secret = var.cipherInfo.secretName
  version = 1
}

data "google_kms_key_ring" "key_ring" {
  name = var.cipherInfo.keyringName
  location = var.projectInfo.region
}

data "google_kms_crypto_key" "crypto_key" {
  name = var.cipherInfo.keyName
  key_ring = data.google_kms_key_ring.key_ring.id
}

resource "google_kms_secret_ciphertext" "cipher_text" {
  crypto_key = data.google_kms_crypto_key.crypto_key.id
  plaintext = data.google_secret_manager_secret_version.secret_version.secret_data
}

output "cipher_text" {
  value = google_kms_secret_ciphertext.cipher_text.ciphertext
}

