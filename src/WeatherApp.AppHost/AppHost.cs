var builder = DistributedApplication.CreateBuilder(args);

var api = builder.AddProject<Projects.WeatherApp_Api>("weatherapi");

var frontend = builder.AddViteApp("frontend", "../WeatherApp.Web")
    .WithNpmPackageInstallation()
    .WithReference(api)
    .WithEnvironment("BROWSER", "false")
    .WithExternalHttpEndpoints();

builder.Build().Run();
