using Microsoft.EntityFrameworkCore;

namespace WeatherApp.Data;

public class WeatherContext : DbContext
{
    public WeatherContext(DbContextOptions<WeatherContext> options) : base(options)
    {
    }

    public DbSet<WeatherForecast> WeatherForecasts { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<WeatherForecast>()
            .ToContainer("WeatherData")
            .HasPartitionKey(w => w.Date);
    }
}