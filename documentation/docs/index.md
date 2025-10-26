# Blog Platform with .NET Aspire

Welcome to the Blog Platform documentation. This project is a modern, cloud-native blogging platform built with .NET Aspire, featuring a full-stack application with API, web interface, and supporting infrastructure.

## Overview

This platform demonstrates modern application development practices using:

- **.NET Aspire** for cloud-native orchestration
- **TypeSpec** for API contract definitions
- **Terraform** for infrastructure as code
- **Azure** cloud services
- **Containerized deployments** with DevContainers

## Quick Links

- [Architecture Overview](architecture/overview.md)
- [Getting Started](getting-started/index.md)
- [Development Guide](development/index.md)
- [Infrastructure](infrastructure/index.md)
- [CI/CD Pipelines](pipelines/index.md)

## Project Structure

```
blog-platform-aspire/
├── .azdo/              # Azure DevOps pipeline definitions
├── .devcontainer/      # Development container configuration
├── documentation/      # This documentation site
├── infra/             # Infrastructure as Code (Terraform)
└── src/               # Application source code
```

## Key Features

- **Microservices Architecture**: Modular services for API, data access, and web presentation
- **Cloud-Native**: Built on .NET Aspire for distributed application development
- **Type-Safe APIs**: API contracts defined with TypeSpec
- **Infrastructure as Code**: Fully automated infrastructure deployment
- **CI/CD Ready**: Complete pipeline automation with Azure DevOps
