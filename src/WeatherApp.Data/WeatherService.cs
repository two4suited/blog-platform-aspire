using Microsoft.EntityFrameworkCore;

namespace WeatherApp.Data;

public interface IWeatherService
{
    Task<List<WeatherForecast>> GetAllForecastsAsync();
    Task<WeatherForecast> AddForecastAsync(WeatherForecast forecast);
}

public class WeatherService : IWeatherService
{
    private readonly WeatherContext _context;

    public WeatherService(WeatherContext context)
    {
        _context = context;
    }

    public async Task<List<WeatherForecast>> GetAllForecastsAsync()
    {
        return await _context.WeatherForecasts.ToListAsync();
    }

    public async Task<WeatherForecast> AddForecastAsync(WeatherForecast forecast)
    {
        _context.WeatherForecasts.Add(forecast);
        await _context.SaveChangesAsync();
        return forecast;
    }
}