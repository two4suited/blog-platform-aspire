# Project Structure

## Top-Level Folders

### `.azdo/`
Azure DevOps pipeline definitions.

**Contents:**
- `documentation.yml` - Documentation build and deployment pipeline

**Purpose:** Defines CI/CD workflows for automated testing, building, and deployment to Azure.

---

### `.devcontainer/`
Development container configuration for VS Code.

**Contents:**
- `devcontainer.json` - Container configuration and features

**Features:**
- .NET 9.0 SDK
- Docker-in-Docker
- Node.js 24.x LTS
- PowerShell
- Pre-configured VS Code extensions

**Purpose:** Provides a consistent, reproducible development environment for all team members.

---

### `documentation/`
Documentation site built with MkDocs and TechDocs.

**Structure:**
```
documentation/
├── docs/              # Documentation content (Markdown)
├── infra/            # Terraform for docs infrastructure
├── mkdocs.yml        # MkDocs configuration
└── site/             # Generated static site (not in Git)
```

**Purpose:** Project documentation, architecture guides, and runbooks hosted as a static website.

---

### `infra/`
Infrastructure as Code for the main application.

**Structure:**
```
infra/
└── environment/
    └── modules/       # Reusable Terraform modules
        └── app-service-plan/
```

**Purpose:** Terraform modules for deploying Azure infrastructure supporting the application.

---

### `src/`
Application source code.

**Projects:**
- `WeatherApp.sln` - Solution file
- `WeatherApp.AppHost/` - .NET Aspire orchestrator
- `WeatherApp.Api/` - Backend API service
- `WeatherApp.Web/` - Frontend web application
- `WeatherApp.Data/` - Data access layer
- `WeatherApp.Seed/` - Database seeding service
- `WeatherApp.ServiceDefaults/` - Shared service configuration
- `WeatherApp.Typespec/` - API contract definitions

**Purpose:** All application code, organized by service and responsibility.

---

## Root Files

### `CODE_OF_CONDUCT.md`
Community guidelines and expected behavior for contributors.

### `LICENSE`
Software license terms (determines how the code can be used).

### `README.md`
Project overview, quick start guide, and essential information.

### `SECURITY.md`
Security policy, vulnerability reporting procedures, and security best practices.

### `.gitignore`
Specifies files and directories to exclude from Git version control:
- Build outputs (`bin/`, `obj/`)
- Dependencies (`node_modules/`)
- Terraform state (`.terraform/`, `*.tfstate`)
- IDE files (`.vs/`, `.vscode/`)
- Secrets and local configuration

---

## Key Concepts

### Separation of Concerns

The folder structure separates:
- **Application code** (`src/`)
- **Infrastructure** (`infra/`, `documentation/infra/`)
- **CI/CD** (`.azdo/`)
- **Development environment** (`.devcontainer/`)
- **Documentation** (`documentation/`)

### Environment Isolation

Each component can be:
- Developed independently
- Deployed separately
- Versioned individually
- Tested in isolation

### Scalability

The structure supports:
- Additional services in `src/`
- Multiple environments in `infra/`
- More pipelines in `.azdo/`
- Extended documentation in `documentation/docs/`
