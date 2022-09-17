provider "google" {
    project = var.projectInfo.project
    region = var.projectInfo.region
    # zone = var.projectInfo.zone
}

data "google_service_account" "service-account" {
  account_id = var.projectInfo.serviceAccount
}

resource "google_workflows_workflow" "workflow" {
  name = var.workflowInfo.name
  region = var.projectInfo.region
  service_account = data.google_service_account.service-account.email
  source_contents = <<EOF
    main:
     params: [input]
     steps:
     - callCloudFunc:
        call: http.get
        args:
            url: https://asia-south1-cloud-native-apps-356206.cloudfunctions.net/cloud-function-hello
            query:
                days: $${input.days}
            headers:
                Authorization: "Bearer $${input.token}"
        result: daysMessage
        next: returnOutput
     - returnOutput:
        return: $${daysMessage}
EOF
}

