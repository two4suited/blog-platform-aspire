var builder = DistributedApplication.CreateBuilder(args);

#pragma warning disable ASPIRECOSMOSDB001

var cosmos = builder.AddAzureCosmosDB("cosmos").RunAsPreviewEmulator(
    emulator =>
    {
        emulator.WithDataExplorer();            
    });

#pragma warning restore ASPIRECOSMOSDB001

var database = cosmos.AddCosmosDatabase("WeatherDB");
var container = database.AddContainer("WeatherData", "/id");

var api = builder.AddProject<Projects.WeatherApp_Api>("weatherapi")
    .WithReference(container);

var frontend = builder.AddViteApp("frontend", "../WeatherApp.Web")
    .WithNpmPackageInstallation()
    .WithReference(api)
    .WithEnvironment("BROWSER", "false")
    .WithExternalHttpEndpoints();

builder.Build().Run();
