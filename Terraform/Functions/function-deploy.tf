provider "google" {
    project = var.projectInfo.project
    region = var.projectInfo.region   
}

data "google_storage_bucket" "bucket" {
  name = var.cloudFunctionInfo.bucketInfo.bucketName
}

resource "google_storage_bucket_object" "cloud_func_archive" {
  name   = var.cloudFunctionInfo.archiveName
  bucket = data.google_storage_bucket.bucket.name
  source = var.cloudFunctionInfo.archiveSource
}

resource "google_cloudfunctions_function" "cloud_func" {
    name = var.cloudFunctionInfo.name
    runtime = var.cloudFunctionInfo.runtime
    trigger_http = var.cloudFunctionInfo.triggerHttp
    entry_point = var.cloudFunctionInfo.entryPoint    
    source_archive_bucket = google_storage_bucket_object.cloud_func_archive.bucket
    source_archive_object = google_storage_bucket_object.cloud_func_archive.name

    depends_on = [
      google_storage_bucket_object.cloud_func_archive
    ]
}

resource "google_cloudfunctions_function_iam_binding" "cloud_func_invoker" {
  project = google_cloudfunctions_function.cloud_func.project
  region = google_cloudfunctions_function.cloud_func.region
  cloud_function = google_cloudfunctions_function.cloud_func.name

  role   = "roles/cloudfunctions.invoker"
  members = [
    "user:${var.projectInfo.user}",
    "serviceAccount:${var.projectInfo.serviceAccount}"
  ]

  depends_on = [
    google_cloudfunctions_function.cloud_func
  ]
}

resource "google_storage_bucket_object" "cloud_pubsub_archive" {
  name   = var.pubsubFunctionInfo.archiveName
  bucket = data.google_storage_bucket.bucket.name
  source = var.pubsubFunctionInfo.archiveSource
}

resource "google_cloudfunctions_function" "cloud_pubsub_func" {
    name = var.pubsubFunctionInfo.name
    runtime = var.pubsubFunctionInfo.runtime
    event_trigger {
      event_type = var.pubsubFunctionInfo.eventTrigger.eventType
      resource = var.pubsubFunctionInfo.eventTrigger.resource
      failure_policy {
        retry = var.pubsubFunctionInfo.eventTrigger.retry
      }      
    }
    entry_point = var.pubsubFunctionInfo.entryPoint    
    source_archive_bucket = google_storage_bucket_object.cloud_pubsub_archive.bucket
    source_archive_object = google_storage_bucket_object.cloud_pubsub_archive.name

    depends_on = [
      google_storage_bucket_object.cloud_pubsub_archive
    ]
}

resource "google_cloudfunctions_function_iam_binding" "cloud_pubsub_invoker" {
  project = google_cloudfunctions_function.cloud_pubsub_func.project
  region = google_cloudfunctions_function.cloud_pubsub_func.region
  cloud_function = google_cloudfunctions_function.cloud_pubsub_func.name

  role   = "roles/cloudfunctions.invoker"
  members = [
    "user:${var.projectInfo.user}",
    "serviceAccount:${var.projectInfo.serviceAccount}"
  ]

  depends_on = [
    google_cloudfunctions_function.cloud_pubsub_func
  ]
}

resource "google_storage_bucket_object" "cloud_storage_archive" {
  name   = var.storageFunctionInfo.archiveName
  bucket = data.google_storage_bucket.bucket.name
  source = var.storageFunctionInfo.archiveSource
}

resource "google_cloudfunctions_function" "cloud_storage_func" {
    name = var.storageFunctionInfo.name
    runtime = var.storageFunctionInfo.runtime
    event_trigger {
      event_type = var.storageFunctionInfo.eventTrigger.eventType
      resource = var.storageFunctionInfo.eventTrigger.resource
      failure_policy {
        retry = var.storageFunctionInfo.eventTrigger.retry
      }      
    }
    entry_point = var.storageFunctionInfo.entryPoint    
    source_archive_bucket = google_storage_bucket_object.cloud_storage_archive.bucket
    source_archive_object = google_storage_bucket_object.cloud_storage_archive.name

    depends_on = [
      google_storage_bucket_object.cloud_storage_archive
    ]
}

resource "google_cloudfunctions_function_iam_binding" "cloud_storage_invoker" {
  project = google_cloudfunctions_function.cloud_storage_func.project
  region = google_cloudfunctions_function.cloud_storage_func.region
  cloud_function = google_cloudfunctions_function.cloud_storage_func.name

  role   = "roles/cloudfunctions.invoker"
  members = [
    "user:${var.projectInfo.user}",
    "serviceAccount:${var.projectInfo.serviceAccount}"
  ]

  depends_on = [
    google_cloudfunctions_function.cloud_storage_func
  ]
}