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

variable "vpcInfo"{
    
    type = object({
        name = string
        routingMode = string
        subnetName = string
        primaryCIDR = string        

    })
    default = {
      name = "cloud-native-vpc"
      primaryCIDR = "11.0.0.0/16"
      routingMode = "REGIONAL"
      subnetName = "linux-vm-subnet"
    }

}