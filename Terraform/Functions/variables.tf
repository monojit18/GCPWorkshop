variable "projectInfo"{
    
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

variable "cloudFunctionInfo"{
    
    type = object({
        name = string
        runtime = string
        triggerHttp = string
        entryPoint = string
        archiveName = string
        archiveSource = string
        bucketInfo = object({
            bucketName = string
            bucketLocation = string
        })        
    })
    default = {
        name = "cloud-function-hello"
        runtime = "dotnet3"
        triggerHttp = true
        entryPoint = "HelloWorld.Function"
        archiveName = "TestCloudFunc.zip"
        archiveSource = "./TestCloudFunc.zip"
        bucketInfo = {
            bucketName = "cloud-function-stg"
            bucketLocation = "asia-south1"
        }
    }    
}

variable "pubsubFunctionInfo"{
    
    type = object({
        name = string
        runtime = string
        eventTrigger = object({
            eventType = string
            resource = string
            retry = bool
        })
        entryPoint = string
        archiveName = string
        archiveSource = string
        bucketInfo = object({
            bucketName = string
            bucketLocation = string
        })        
    })
    default = {
        name = "cloud-pubsub-hello"
        runtime = "dotnet3"
        eventTrigger = {
            eventType = "google.pubsub.topic.publish"
            resource = "cloud-native-topic"
            retry = false
        }
        entryPoint = "HelloPubSub.Function"
        archiveName = "TestPubSubFunc.zip"
        archiveSource = "./TestPubSubFunc.zip"
        bucketInfo = {
            bucketName = "cloud-function-stg"
            bucketLocation = "asia-south1"
        }
    }    
}

variable "storageFunctionInfo"{
    
    type = object({
        name = string
        runtime = string
        eventTrigger = object({
            eventType = string
            resource = string
            retry = bool
        })
        entryPoint = string
        archiveName = string
        archiveSource = string
        bucketInfo = object({
            bucketName = string
            bucketLocation = string
        })        
    })
    default = {
        name = "cloud-storage-hello"
        runtime = "dotnet3"
        eventTrigger = {
            eventType = "google.storage.object.finalize"
            resource = "cloud-native-stg"
            retry = false
        }
        entryPoint = "HelloGcs.Function"
        archiveName = "TestStorageFunc.zip"
        archiveSource = "./TestStorageFunc.zip"
        bucketInfo = {
            bucketName = "cloud-function-stg"
            bucketLocation = "asia-south1"
        }
    }    
}