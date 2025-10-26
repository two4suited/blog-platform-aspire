# Development Guide

## Project Structure

### Source Code Organization

```
src/
├── WeatherApp.sln                  # Solution file
├── WeatherApp.AppHost/             # Aspire orchestrator
├── WeatherApp.Api/                 # Backend API
├── WeatherApp.Web/                 # Frontend application
├── WeatherApp.Data/                # Data access layer
├── WeatherApp.Seed/                # Database seeding
├── WeatherApp.ServiceDefaults/     # Shared configuration
└── WeatherApp.Typespec/            # API contracts
```

## Development Environment

### DevContainer Configuration

The project includes a complete development container configuration in `.devcontainer/`:

**Features:**
- Base image: `mcr.microsoft.com/devcontainers/dotnet:9.0-bookworm`
- Docker-in-Docker support
- PowerShell
- Node.js LTS (24.x)
- Pre-installed extensions:
  - C# Dev Kit
  - GitHub Copilot
  - TypeSpec for VS Code

**Post-Create Setup:**
- Installs .NET Aspire via install script
- Installs TypeSpec compiler globally
- Trusts development certificates

### VS Code Extensions

Recommended extensions are automatically installed in the DevContainer:
- `ms-dotnettools.csdevkit` - C# development
- `GitHub.copilot` - AI pair programming
- `GitHub.copilot-chat` - AI assistant
- `typespec.typespec-vscode` - TypeSpec language support

## Working with TypeSpec

### API Contract Development

TypeSpec files are located in `src/WeatherApp.Typespec/`:

1. **Edit TypeSpec Files**
   - Define models, operations, and routes
   - TypeSpec provides IntelliSense and validation

2. **Generate Code**
   ```bash
   cd src/WeatherApp.Typespec
   npm run build
   ```

3. **Generated Outputs**
   - OpenAPI specifications
   - Client SDKs
   - Server stubs (if configured)

### TypeSpec Best Practices

- Keep models in separate files
- Use namespaces for organization
- Document all public APIs with `@doc`
- Version your APIs appropriately

## Database Development

### Entity Framework Core

The `WeatherApp.Data` project uses EF Core for data access:

**Key Files:**
- `WeatherContext.cs` - DbContext definition
- `WeatherForecast.cs` - Entity models
- `WeatherService.cs` - Data service layer
- `ServiceExtensions.cs` - DI configuration

### Migrations

```bash
# Add a new migration
cd src/WeatherApp.Data
dotnet ef migrations add MigrationName

# Update database
dotnet ef database update

# Remove last migration
dotnet ef migrations remove
```

### Seeding Data

The `WeatherApp.Seed` project runs as a background worker:

- Automatically executes on startup
- Populates initial data
- Customize in `Worker.cs`

## Frontend Development

### Web Application Stack

Located in `src/WeatherApp.Web/`:

**Technology:**
- Vite - Build tool and dev server
- TypeScript - Type-safe JavaScript
- ESLint - Code linting

**Key Commands:**
```bash
cd src/WeatherApp.Web

# Install dependencies
npm install

# Start dev server
npm run dev

# Build for production
npm run build

# Run linter
npm run lint
```

### Configuration Files

- `vite.config.ts` - Vite configuration
- `tsconfig.json` - TypeScript compiler options
- `eslint.config.js` - Linting rules
- `package.json` - Dependencies and scripts

## Debugging

### Using .NET Aspire Dashboard

1. Run the AppHost project
2. Open the Aspire Dashboard (URL shown in console)
3. View:
   - Service status and health
   - Logs from all services
   - Distributed traces
   - Metrics and performance data

### VS Code Debugging

Launch configurations are in `.vscode/launch.json`:

- **Debug AppHost** - Start the entire application
- **Debug API** - Debug just the API service
- **Debug Web** - Debug the frontend

### Troubleshooting

**Common Issues:**

1. **Port Conflicts**
   - Check `launchSettings.json` in each project
   - Aspire dynamically assigns ports by default

2. **Database Connection**
   - Ensure connection strings are correct in `appsettings.json`
   - Check that database service is running

3. **Certificate Issues**
   ```bash
   dotnet dev-certs https --clean
   dotnet dev-certs https --trust
   ```

## Code Standards

### C# Conventions

- Follow [Microsoft C# Coding Conventions](https://docs.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style/coding-conventions)
- Use nullable reference types
- Prefer async/await for I/O operations
- Use dependency injection

### TypeScript Conventions

- Enable strict mode
- Use interfaces for contracts
- Prefer const over let
- Use arrow functions for callbacks

## Testing

### Unit Tests

```bash
# Run all tests
dotnet test

# Run specific test project
dotnet test WeatherApp.Api.Tests

# Watch mode
dotnet watch test
```

### Integration Tests

Integration tests should:
- Use WebApplicationFactory for API tests
- Use in-memory database or test containers
- Clean up resources after each test

## Git Workflow

### Branch Strategy

- `main` - Production-ready code
- Feature branches: `feature/description`
- Bug fixes: `fix/description`

### Commit Messages

Follow conventional commits:
```
feat: add new weather endpoint
fix: resolve null reference in data service
docs: update API documentation
chore: update dependencies
```

### Ignored Files

See `.gitignore` for ignored files including:
- `bin/` and `obj/` directories
- `node_modules/`
- `.terraform/` and `*.tfstate`
- User-specific IDE files
