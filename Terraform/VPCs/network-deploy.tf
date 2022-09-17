provider "google" {
    project = var.projectInfo.project
    region = var.projectInfo.region
    zone = var.projectInfo.zone
  
}

resource "google_compute_network" "vpc-network" {
  name = var.vpcInfo.name
  auto_create_subnetworks = false
  routing_mode = var.vpcInfo.routingMode

}

resource "google_compute_subnetwork" "vpc-subnetwork" {
  name = var.vpcInfo.subnetName
  ip_cidr_range = var.vpcInfo.primaryCIDR
  stack_type = "IPV4_ONLY"
  network = google_compute_network.vpc-network.id

}