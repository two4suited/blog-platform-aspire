using WeatherApi;
using WeatherApp.Data;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi();
builder.AddServiceDefaults();

// Add Entity Framework with Cosmos DB - connection is injected automatically by Aspire
builder.AddCosmosDbContext<WeatherContext>("WeatherData");

// Register weather services from the Data project
builder.Services.AddScoped<IWeatherForecasts, WeatherService>();
builder.Services.AddControllers();

var app = builder.Build();

app.UseHttpsRedirection();
app.MapControllers();
app.Run();

