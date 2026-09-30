using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Components;

namespace BlazorApp.Shared
{
    public static class Logging
    {
        public static void Log(ILogger logger, RendererInfo rendererInfo, string component, bool prerender, string method)
        {
            logger.LogInformation($"In {component}(prerender:{prerender}), method {method}:");
            logger.LogInformation($"Is Browser: { OperatingSystem.IsBrowser()}");
            logger.LogInformation($"Machine Name: {Environment.MachineName}");
            logger.LogInformation($"Render Mode: {rendererInfo.Name}");
            logger.LogInformation($"Is Interactive: {rendererInfo.IsInteractive}");
        }
    }
}
