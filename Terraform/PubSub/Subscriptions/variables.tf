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
        subscriptionName = string
        topicName = string
        ackDeadline = number
        retainAckMessages = bool
        retentionDuration = string
    })
    default = {
        subscriptionName = "cloud-native-subscription"
        topicName = "cloud-native-topic"
        ackDeadline = 20
        retainAckMessages = true        
        retentionDuration = "1200s"
    }
}