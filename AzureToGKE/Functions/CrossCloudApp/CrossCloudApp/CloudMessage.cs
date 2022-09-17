using System;
using Newtonsoft.Json;

namespace CrossCloudApp
{
    public class CloudMessage
    {

        [JsonProperty("recipients")]
        public string Recipients { get; set; }

        [JsonProperty("subject")]
        public string Subject { get; set; } 

        [JsonProperty("message")]
        public string Message { get; set; } 

    }
}
