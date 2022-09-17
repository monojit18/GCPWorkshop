variable "projectInfo"{
    type = object({
        project = string
        region = string
        zone = string
        user = string
        serviceAccount = string
    })
    default = {
        project = "cloud-native-apps-356206"
        region = "asia-south1"
        zone = "asia-south1-a"
        user = "datta.monojit@gmail.com"
        serviceAccount = "cloud-native-sa"
    }
}

variable "keyringInfo"{    
    type = object({
        keyringName = string
        role = string
    })
    default = {
      keyringName = "cloud-native-keyring"
      role = "roles/editor"
    }
}