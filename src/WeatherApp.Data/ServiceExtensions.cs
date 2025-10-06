using Microsoft.Extensions.DependencyInjection;

namespace WeatherApp.Data;

public static class ServiceExtensions
{
    public static IServiceCollection AddWeatherServices(this IServiceCollection services)
    {
        services.AddScoped<IWeatherService, WeatherService>();
        return services;
    }
}