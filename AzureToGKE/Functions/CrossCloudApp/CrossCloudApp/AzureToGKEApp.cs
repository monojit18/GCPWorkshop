using System;
using System.IO;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace CrossCloudApp
{
    public static class AzureToGKE
    {
        private static HttpClient httpClient = new HttpClient();

        private static async Task<string> sendEmailAsync(CloudMessage message, ILogger log)
        {

            var logicAppCallbackUri = Environment.GetEnvironmentVariable("LOGICAPP_CALLBACK_URL");
            var logicAppPostUri = Environment.GetEnvironmentVariable("LOGICAPP_POST_URL");

            var responseMessage = await httpClient.PostAsync(logicAppCallbackUri, null);            
            var responseContent = await responseMessage.Content.ReadAsStringAsync();
            log.LogInformation($"Callback:{responseContent}");

            var callbackModel = JsonConvert.DeserializeObject<CallbackModel>(responseContent);
            var signature = callbackModel.Queries.Signature;
            logicAppPostUri = string.Format(logicAppPostUri, signature);
            log.LogInformation($"PostUri:{logicAppPostUri}");

            var body = JsonConvert.SerializeObject(message);
            log.LogInformation($"Body:{body}");
            
            var bodyContent = new StringContent(body);
            bodyContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

            responseMessage = await httpClient.PostAsync(logicAppPostUri, bodyContent);
            responseContent = await responseMessage.Content.ReadAsStringAsync();
            log.LogInformation($"ResponseContent:{responseContent}");
            return responseContent;
        }

        [FunctionName("fromgke")]
        public static async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "post", Route = "message")] HttpRequest req,
            ILogger log)
        {            
            
            var reader = new StreamReader(req.Body);            
            var body = await reader.ReadToEndAsync();
            var cloudMessage = JsonConvert.DeserializeObject<CloudMessage>(body);
            cloudMessage.Message = "I was born in Azure; now living in GKE";            
            await sendEmailAsync(cloudMessage, log);
            return new OkObjectResult("OK");

        }
    }
}
