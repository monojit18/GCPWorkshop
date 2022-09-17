provider "google" {
    project = var.projectInfo.project     
}

resource "google_pubsub_subscription" "cloud_pubsub_subscription" {
    name = var.pubsubInfo.subscriptionName
    topic = var.pubsubInfo.topicName
    ack_deadline_seconds = var.pubsubInfo.ackDeadline
    retain_acked_messages = var.pubsubInfo.retainAckMessages
    message_retention_duration = var.pubsubInfo.retentionDuration
}

resource "google_pubsub_subscription_iam_binding" "subscription_binding" {
  project = google_pubsub_subscription.cloud_pubsub_subscription.project
  subscription = google_pubsub_subscription.cloud_pubsub_subscription.name
  role   = "roles/pubsub.admin"
  members = [
    "user:${var.projectInfo.user}",
    "serviceAccount:${var.projectInfo.serviceAccount}"
  ]

  depends_on = [
    google_pubsub_subscription.cloud_pubsub_subscription
  ]
}