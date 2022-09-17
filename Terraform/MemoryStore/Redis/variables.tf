variable "projectInfo"{
    
    type = object({
        project = string
        region = string
        zone = string
        user = string

    })
    default = {
        project = "cloud-native-apps-356206"
        region = "asia-south2"
        zone = "asia-south2-a"
        user = "datta.monojit@gmail.com"
    }
}

variable "memstoreInfo"{
    
    type = object({
        name = string
        memorySizeinGB  = number
        tier = string
        replicaCount = number
        version = string

    })
    default = {
        name = "cloud-native-ms"
        memorySizeinGB  = 2
        tier = "STANDARD_HA"
        replicaCount = 3
        version = "REDIS_5_0"
    }

}