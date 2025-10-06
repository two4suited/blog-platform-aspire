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
        modelBuilder.Entity<WeatherForecast>(entity =>
        {
            entity.ToContainer("WeatherData");
            entity.HasKey(w => w.Id);
            entity.HasPartitionKey(w => w.Location);
        });
    }
}