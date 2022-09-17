provider "google" {
    project = var.projectInfo.project     
}

resource "google_pubsub_topic" "cloud_pubsub_topic" {
    name = var.pubsubInfo.topicName
    message_retention_duration = var.pubsubInfo.retentionDuration
}

resource "google_pubsub_topic_iam_binding" "topic_binding" {
  project = google_pubsub_topic.cloud_pubsub_topic.project
  topic = google_pubsub_topic.cloud_pubsub_topic.name
  role   = "roles/pubsub.admin"
  members = [
    "user:${var.projectInfo.user}",
    "serviceAccount:${var.projectInfo.serviceAccount}"
  ]

  depends_on = [
    google_pubsub_topic.cloud_pubsub_topic
  ]
}