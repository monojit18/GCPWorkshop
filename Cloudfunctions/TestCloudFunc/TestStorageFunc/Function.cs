using CloudNative.CloudEvents;
using Google.Cloud.Functions.Framework;
using Google.Events.Protobuf.Cloud.Storage.V1;
using Microsoft.Extensions.Logging;
using System.Threading;
using System.Threading.Tasks;

namespace HelloGcs
{
    
    public class Function : ICloudEventFunction<StorageObjectData>
    {
        private readonly ILogger _logger;

        public Function(ILogger<Function> logger) =>
            _logger = logger;

        public Task HandleAsync(CloudEvent cloudEvent, StorageObjectData data, CancellationToken cancellationToken)
        {
            _logger.LogInformation("Event: {event}", cloudEvent.Id);
            _logger.LogInformation("Event Type: {type}", cloudEvent.Type);
            _logger.LogInformation("Bucket: {bucket}", data.Bucket);
            _logger.LogInformation("File: {file}", data.Name);
            _logger.LogInformation("Metageneration: {metageneration}", data.Metageneration);
            _logger.LogInformation("Created: {created:s}", data.TimeCreated?.ToDateTimeOffset());
            _logger.LogInformation("Updated: {updated:s}", data.Updated?.ToDateTimeOffset());
            return Task.CompletedTask;
        }
    }
}