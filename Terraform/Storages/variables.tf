variable "projectInfo"{
    
    type = object({
        project = string
        region = string
        zone = string

    })
    default = {
        project = "cloud-native-apps-356206"
        region = "asia-south2"
        zone = "asia-south2-a"
    }
}

variable "bucketInfo"{
    
    type = object({
        name = string
        location = string
        storageClass = string

    })
    default = {
      name = "cloud-native-stg"
      location = "asia-south2"
      storageClass = "STANDARD"

    }

}