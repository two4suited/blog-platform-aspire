namespace WeatherApp.Data;

public record WeatherForecast(Guid Id, DateOnly Date, int TemperatureC, string? Summary, string Location)
{
    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
}