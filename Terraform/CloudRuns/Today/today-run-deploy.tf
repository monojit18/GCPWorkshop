provider "google" {
    project = var.projectInfo.project
    region = var.projectInfo.region   
}

resource "google_cloud_run_service" "today_cloud_run" {
    name = var.cloudRunInfo.name
    location = var.projectInfo.region
    template {
      spec {
        containers {
          image = var.cloudRunInfo.spec.image
          ports {
            container_port = 8080
          }
        }    
        service_account_name = var.projectInfo.serviceAccount
      }
    }

    traffic {
      percent = var.cloudRunInfo.spec.traffic
      latest_revision = true
    }

    metadata {
      annotations = {
        "run.googleapis.com/ingress" = var.cloudRunInfo.spec.annotations
      }
    }
}

resource "google_cloud_run_service_iam_binding" "today_run_binding" {
  project = google_cloud_run_service.today_cloud_run.project
  location = google_cloud_run_service.today_cloud_run.location
  service = google_cloud_run_service.today_cloud_run.name
  role = "roles/run.invoker"
  members = [
    "serviceAccount:cloud-native-workshop-sa@cloud-native-workshop.iam.gserviceaccount.com"
  ]
}
