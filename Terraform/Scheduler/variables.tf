variable "projectInfo" {
    type = object({
        project = string
        region = string
        user = string
        serviceAccount = string
    })
    default = {
        project = "cloud-native-apps-356206"
        region = "asia-south1"
        user = "datta.monojit@gmail.com"
        serviceAccount = "cloud-native-sa@cloud-native-apps-356206.iam.gserviceaccount.com"
    }
}

variable "schedulerInfo" {
    type = object({
        schedulerName = string
        schedulerConfig = string
        pubsubTarget = object({
            topicName = string
            data = string
        })
    })
    default = {
        schedulerName = "cloud-native-scheduler"
        schedulerConfig = "* * * * *"
        pubsubTarget = {
            topicName = "cloud-native-topic"
            data = "hello from scheduler"
        }      
    }
}