var builder = DistributedApplication.CreateBuilder(args);

var api = builder.AddProject<Projects.WeatherApp_Api>("weatherapi");

builder.Build().Run();
