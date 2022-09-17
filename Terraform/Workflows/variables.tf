variable "projectInfo" {
    type = object({
        project = string
        region = string
        # zone = string
        user = string
        serviceAccount = string

    })
    default = {
        project = "cloud-native-apps-356206"
        region = "asia-south1"
        # zone = "asia-south2-a"
        user = "datta.monojit@gmail.com"
        serviceAccount = "cloud-native-sa"
    }
}

variable "workflowInfo" {
    type = object({
        name = string        

    })
    default = {
      name = "cloud-native-wf"
    }
}