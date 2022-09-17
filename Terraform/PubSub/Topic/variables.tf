variable "projectInfo" {
    type = object({
        project = string        
        user = string
        serviceAccount = string
    })
    default = {
        project = "cloud-native-apps-356206"        
        user = "datta.monojit@gmail.com"
        serviceAccount = "cloud-native-sa@cloud-native-apps-356206.iam.gserviceaccount.com"
    }
}

variable "pubsubInfo" {
    type = object({
        topicName = string        
        retentionDuration = string
    })
    default = {
      topicName = "cloud-native-topic"
      retentionDuration = "86400s"
    }
}