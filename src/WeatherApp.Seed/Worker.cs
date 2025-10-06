using WeatherApp.Data;

namespace WeatherApp.Seed;

public class Worker : BackgroundService
{
    private readonly ILogger<Worker> _logger;
    private readonly IServiceScopeFactory _serviceScopeFactory;
    private readonly IHostApplicationLifetime _hostApplicationLifetime;

    public Worker(ILogger<Worker> logger, IServiceScopeFactory serviceScopeFactory, IHostApplicationLifetime hostApplicationLifetime)
    {
        _logger = logger;
        _serviceScopeFactory = serviceScopeFactory;
        _hostApplicationLifetime = hostApplicationLifetime;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _logger.LogInformation("Weather Seeder starting at: {time}", DateTimeOffset.Now);
        
        using var scope = _serviceScopeFactory.CreateScope();
        var weatherService = scope.ServiceProvider.GetRequiredService<IWeatherService>();
        
        // Check if data already exists
        var existingForecasts = await weatherService.GetAllForecastsAsync();
        if (existingForecasts.Any())
        {
            _logger.LogInformation("Weather data already exists. Skipping seed.");
            _hostApplicationLifetime.StopApplication();
            return;
        }

        // Seed fake weather data
        _logger.LogInformation("Seeding weather data...");
        
        var summaries = new[]
        {
            "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
        };

        var cities = new[]
        {
            "New York, USA", "London, UK", "Tokyo, Japan", "Sydney, Australia", "Paris, France",
            "Berlin, Germany", "Toronto, Canada", "Mumbai, India", "São Paulo, Brazil", "Cairo, Egypt",
            "Moscow, Russia", "Beijing, China", "Mexico City, Mexico", "Lagos, Nigeria", "Bangkok, Thailand",
            "Dubai, UAE", "Singapore", "Buenos Aires, Argentina", "Stockholm, Sweden", "Amsterdam, Netherlands"
        };

        var forecasts = Enumerable.Range(1, 5).Select(index =>
            new WeatherForecast
            (
                Guid.NewGuid(),
                DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
                Random.Shared.Next(-20, 55),
                summaries[Random.Shared.Next(summaries.Length)],
                cities[Random.Shared.Next(cities.Length)]
            ))
            .ToArray();

        foreach (var forecast in forecasts)
        {
            await weatherService.AddForecastAsync(forecast);
            _logger.LogInformation("Added forecast: {Date} - {Summary} - {TempC}°C", 
                forecast.Date, forecast.Summary, forecast.TemperatureC);
        }
        
        _logger.LogInformation("Weather Seeder completed seeding {Count} forecasts at: {time}", 
            forecasts.Length, DateTimeOffset.Now);
        
        // Stop the application after seeding is complete
        _hostApplicationLifetime.StopApplication();
    }
}