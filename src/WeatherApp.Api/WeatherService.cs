using System.Text.Json.Nodes;
using WeatherApi;
using WeatherApp.Data;
using Microsoft.EntityFrameworkCore;

public class WeatherService : IWeatherForecasts
{
    private readonly WeatherContext _context;

    public WeatherService(WeatherContext context)
    {
        _context = context;
    }

    public async Task<JsonNode> AddForecastAsync(WeatherApi.WeatherForecast body)
    {
        var entity = new WeatherApp.Data.WeatherForecast(
            Guid.NewGuid(),
            DateOnly.FromDateTime(body.Date),
            body.TemperatureC,
            body.Summary,
            body.Location
        );
        _context.WeatherForecasts.Add(entity);
        await _context.SaveChangesAsync();
        return System.Text.Json.JsonSerializer.SerializeToNode(entity) ?? new JsonObject();
    }

    public async Task<JsonNode> ListForecastsAsync()
    {
        var forecasts = await _context.WeatherForecasts.ToListAsync();
        var json = System.Text.Json.JsonSerializer.Serialize(forecasts);
        var node = JsonNode.Parse(json);
        return node ?? new JsonArray();
    }
}