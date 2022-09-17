using System;
using System.Threading.Tasks;
using Google.Cloud.Functions.Framework;
using Microsoft.AspNetCore.Http;


namespace HelloWorld
{
    public class Function : IHttpFunction
    {
        public async Task HandleAsync(HttpContext context)
        {

            var request = context.Request;
            var daysToAdd = (string)(request.Query["days"]);
            var daysToReturn = DateTime.Today.AddDays(int.Parse(daysToAdd))
                                             .ToLongDateString();            
            await context.Response.WriteAsync($"Hello World Date - {daysToReturn}");

        }
    }
}