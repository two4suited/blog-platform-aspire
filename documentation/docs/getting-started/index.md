# Getting Started

## Prerequisites

Before you begin, ensure you have the following installed:

- [.NET 9.0 SDK](https://dotnet.microsoft.com/download/dotnet/9.0)
- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [Visual Studio Code](https://code.visualstudio.com/) or [Visual Studio 2022](https://visualstudio.microsoft.com/)
- [Node.js 24.x LTS](https://nodejs.org/)

## Quick Start

### Option 1: Using DevContainer (Recommended)

1. **Open in DevContainer**
   ```bash
   # Clone the repository
   git clone https://github.com/two4suited/blog-platform-aspire.git
   cd blog-platform-aspire
   
   # Open in VS Code
   code .
   
   # Reopen in Container when prompted
   ```

2. **The DevContainer includes:**
   - .NET 9.0 SDK
   - Docker-in-Docker support
   - Node.js LTS
   - PowerShell
   - .NET Aspire workload
   - TypeSpec compiler

### Option 2: Local Development

1. **Clone the Repository**
   ```bash
   git clone https://github.com/two4suited/blog-platform-aspire.git
   cd blog-platform-aspire
   ```

2. **Install .NET Aspire**
   ```bash
   dotnet workload install aspire
   ```

3. **Install TypeSpec**
   ```bash
   npm install -g @typespec/compiler
   ```

4. **Restore Dependencies**
   ```bash
   cd src
   dotnet restore
   ```

## Running the Application

### Start with .NET Aspire

1. **Navigate to AppHost**
   ```bash
   cd src/WeatherApp.AppHost
   ```

2. **Run the Application**
   ```bash
   dotnet run
   ```

3. **Access the Dashboard**
   - Open your browser to the URL displayed in the console (typically `http://localhost:15xxx`)
   - The Aspire dashboard shows all running services

4. **Access the Application**
   - Web UI: Check the dashboard for the Web service URL
   - API: Check the dashboard for the API service URL

## Development Workflow

### Building the Solution

```bash
# Build all projects
cd src
dotnet build

# Build specific project
dotnet build WeatherApp.Api
```

### Running Tests

```bash
# Run all tests
dotnet test

# Run with coverage
dotnet test --collect:"XPlat Code Coverage"
```

### Database Setup

The seed service automatically populates the database on startup. No manual steps required.

## Next Steps

- [Development Guide](../development/index.md) - Learn about the development workflow
- [Architecture](../architecture/overview.md) - Understand the system design
- [Infrastructure](../infrastructure/index.md) - Deploy to Azure
