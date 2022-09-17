provider "google" {
    project = var.projectInfo.project
    region = var.projectInfo.region
    zone = var.projectInfo.zone
  
}

resource "google_storage_bucket" "stg-bucket" {
    name = var.bucketInfo.name
    location = var.bucketInfo.location
    storage_class = var.bucketInfo.storageClass
  
}

output "bucket-id" {
  value = google_storage_bucket.stg-bucket.id
  
}