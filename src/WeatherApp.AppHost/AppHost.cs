var builder = DistributedApplication.CreateBuilder(args);

#pragma warning disable ASPIRECOSMOSDB001

var cosmos = builder.AddAzureCosmosDB("cosmos").RunAsPreviewEmulator(
    emulator =>
    {
        emulator.WithDataExplorer();            
    });

#pragma warning restore ASPIRECOSMOSDB001

var database = cosmos.AddCosmosDatabase("WeatherDB");
var container = database.AddContainer("WeatherData", "/location");

var api = builder.AddProject<Projects.WeatherApp_Api>("weatherapi")
    .WithReference(container);

var seeder = builder.AddProject<Projects.WeatherApp_Seed>("weatherseeder")
    .WithReference(container)
    .WithExplicitStart();

var swagger = builder.AddContainer("swagger-ui", "swaggerapi/swagger-ui")
    .WithBindMount("../generated/openapi/openapi.yaml", "/usr/share/nginx/html/openapi.yaml")
    .WithEnvironment("SWAGGER_JSON_URL", "/openapi.yaml")
    .WithHttpEndpoint(targetPort: 8080, name: "swagger");

var frontend = builder.AddViteApp("frontend", "../WeatherApp.Web")
    .WithNpmPackageInstallation()
    .WithReference(api)
    .WithEnvironment("BROWSER", "false")
    .WithExternalHttpEndpoints();

builder.Build().Run();
