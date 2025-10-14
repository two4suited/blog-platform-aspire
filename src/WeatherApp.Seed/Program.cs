using WeatherApp.Data;
using WeatherApp.Seed;

var builder = Host.CreateApplicationBuilder(args);

builder.AddServiceDefaults();

// Add Entity Framework with Cosmos DB
builder.AddCosmosDbContext<WeatherContext>("WeatherData");

// Register weather services from the Data project


builder.Services.AddHostedService<Worker>();

var host = builder.Build();
host.Run();
