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

variable "secretInfo"{
    type = object({
        secretName = string
        automatic = bool
        role = string
    })
    default = {
      secretName = "cloud-native-secret"
      automatic = true
      role = "roles/secretmanager.secretAccessor"
    }
}