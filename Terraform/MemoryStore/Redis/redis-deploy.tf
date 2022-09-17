provider "google" {
    project = var.projectInfo.project
    region = var.projectInfo.region
    zone = var.projectInfo.zone
  
}

resource "google_redis_instance" "memstore-redis" {
    name = var.memstoreInfo.name
    memory_size_gb = var.memstoreInfo.memorySizeinGB
    tier = var.memstoreInfo.tier
    # replica_count = var.memstoreInfo.replicaCount
    redis_version = var.memstoreInfo.version
  
}