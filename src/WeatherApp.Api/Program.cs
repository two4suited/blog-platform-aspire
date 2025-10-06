using WeatherApp.Data;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi();
builder.AddServiceDefaults();

// Add Entity Framework with Cosmos DB - connection is injected automatically by Aspire
builder.AddCosmosDbContext<WeatherContext>("WeatherData");

// Register weather services from the Data project
builder.Services.AddWeatherServices();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

app.UseHttpsRedirection();

app.MapGet("/weatherforecast", async (IWeatherService weatherService) =>
{
    var forecasts = await weatherService.GetAllForecastsAsync();
    return Results.Ok(forecasts);
})
.WithName("GetWeatherForecast");

app.Run();

