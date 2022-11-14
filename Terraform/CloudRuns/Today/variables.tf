variable "projectInfo"{
    
    type = object({
        project = string
        region = string        
        user = string
        serviceAccount = string

    })
    default = {
        project = "cloud-native-workshop"
        region = "asia-southeast1"        
        user = "datta.monojit@gmail.com"
        serviceAccount = "cloud-native-workshop-sa@cloud-native-workshop.iam.gserviceaccount.com"
    }
}

variable "cloudRunInfo"{
    
    type = object({
        name = string
        spec = object({
            image = string
            annotations = string
            traffic = number
        })        
    })
    default = {
        name = "today-cloud-run"
        spec = {
            image = "<repo-name>/cloud-native-workshop/cloud-native-repo/today-cloud-run:v1.0"
            annotations = "internal-and-cloud-load-balancing"
            traffic = 100            
        }
    }    
}