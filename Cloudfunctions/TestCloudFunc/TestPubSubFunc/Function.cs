using CloudNative.CloudEvents;
using Google.Cloud.Functions.Framework;
using Google.Events.Protobuf.Cloud.PubSub.V1;
using Microsoft.Extensions.Logging;
using System.Threading;
using System.Threading.Tasks;

namespace HelloPubSub
{
    public class Function : ICloudEventFunction<MessagePublishedData>
    {
        private readonly ILogger _logger;

        public Function(ILogger<Function> logger) =>
            _logger = logger;

        public Task HandleAsync(CloudEvent cloudEvent, MessagePublishedData data, CancellationToken cancellationToken)
        {
            string nameFromMessage = data.Message?.TextData;
            string name = string.IsNullOrEmpty(nameFromMessage) ? "world" : nameFromMessage;
            _logger.LogInformation("Hello {name}", name);
            return Task.CompletedTask;
        }
    }
}