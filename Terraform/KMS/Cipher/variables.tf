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

variable "cipherInfo"{    
    type = object({
        secretName = string
        keyringName = string
        keyName = string
    })
    default = {
      secretName = "cloud-native-secret"
      keyringName = "cloud-native-keyring"
      keyName = "cloud-native-ec-key"
    }
}