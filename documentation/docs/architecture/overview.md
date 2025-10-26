# Architecture Overview

## System Architecture

The Blog Platform is built using a modern microservices architecture orchestrated by .NET Aspire, providing a scalable and maintainable cloud-native application.

## Components

### Application Services

```
┌─────────────────┐
│  WeatherApp.Web │  - Frontend Application
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  WeatherApp.Api │  - RESTful API Service
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ WeatherApp.Data │  - Data Access Layer
└─────────────────┘
```

### Core Projects

#### **WeatherApp.AppHost**
The .NET Aspire orchestrator that manages service discovery, configuration, and local development experience.

- Configures service endpoints
- Manages dependencies between services
- Provides dashboard for monitoring

#### **WeatherApp.Api**
RESTful API service providing backend functionality.

- Exposes HTTP endpoints
- Implements business logic
- Integrates with data layer

#### **WeatherApp.Web**
Modern web frontend built with TypeScript/Vite.

- Single-page application (SPA)
- Consumes API services
- Responsive user interface

#### **WeatherApp.Data**
Data access layer handling persistence.

- Entity Framework Core integration
- Database context management
- Repository pattern implementation

#### **WeatherApp.Seed**
Database seeding service for initial data population.

- Runs as a background worker
- Populates initial datasets
- Development and testing support

#### **WeatherApp.ServiceDefaults**
Shared service configuration and extensions.

- Common middleware configuration
- Health checks
- Observability setup

#### **WeatherApp.Typespec**
API contract definitions using TypeSpec.

- Type-safe API specifications
- Code generation for clients
- OpenAPI documentation

## Technology Stack

- **.NET 9.0**: Latest .NET framework
- **ASP.NET Core**: Web framework
- **Entity Framework Core**: ORM
- **TypeSpec**: API specification language
- **Vite**: Frontend build tool
- **Azure Services**: Cloud hosting

## Design Principles

1. **Separation of Concerns**: Each project has a single, well-defined responsibility
2. **Dependency Injection**: Loose coupling through DI container
3. **Cloud-Native**: Built for containerized, distributed deployment
4. **Type Safety**: Strongly-typed contracts across the stack
5. **Observability**: Built-in monitoring, logging, and tracing
