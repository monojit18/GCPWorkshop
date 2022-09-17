provider "google" {
    project = var.projectInfo.project     
}

data "google_pubsub_topic" "cloud_pubsub_topic" {
    name = var.schedulerInfo.pubsubTarget.topicName
}

resource "google_cloud_scheduler_job" "cloud_scheduler_job" {
  name = var.schedulerInfo.schedulerName
  region = var.projectInfo.region  
  schedule = var.schedulerInfo.schedulerConfig
  time_zone = "Asia/Kolkata"
  pubsub_target {
    topic_name = data.google_pubsub_topic.cloud_pubsub_topic.id
    data = base64encode(var.schedulerInfo.pubsubTarget.data)
  }
}