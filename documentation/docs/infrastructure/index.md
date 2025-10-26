# Infrastructure

## Overview

The infrastructure for this project is managed using Terraform and deployed to Azure. The infrastructure code is organized to support multiple environments and automated deployments.

## Directory Structure

```
blog-platform-aspire/
├── infra/                    # Environment-level infrastructure
│   └── environment/
│       └── modules/         # Reusable Terraform modules
│           └── app-service-plan/
└── documentation/
    └── infra/              # Documentation site infrastructure
```

## Infrastructure Components

### Documentation Infrastructure

Located in `documentation/infra/`, this Terraform configuration deploys:

- **Azure Storage Account** - Static website hosting
- **Azure Front Door** - CDN and global load balancing
- **Resource Groups** - Logical resource organization

The documentation site is hosted as a static website in Azure Blob Storage, delivered globally through Azure Front Door for optimal performance.

### Application Infrastructure

Located in `infra/environment/`, this configuration supports the main application:

#### Terraform Modules

**App Service Plan (`modules/app-service-plan/`)**
- Creates Azure App Service Plans
- Environment-specific SKU selection:
  - Production: `P1v3` (Premium v3)
  - Non-production: `P0v3` (Basic)
- Linux-based hosting
- Supports auto-scaling

### Environment Strategy

Infrastructure supports multiple environments:
- **Test** - Development and testing
- **Production** - Live production workloads

Environment-specific variables control:
- Resource naming conventions
- SKU/tier selections
- Scaling configurations
- Network settings

## Terraform Configuration

### Backend Configuration

The project uses **Terraform Cloud** for remote state management:

**Benefits:**
- Centralized state storage
- State locking to prevent conflicts
- Collaboration support
- Audit logging
- Secure variable storage

### Variables and Secrets

**Variable Types:**
- **Terraform Variables** - Infrastructure configuration
- **Environment Variables** - Runtime secrets (API keys, tokens)

**Best Practices:**
- Never commit secrets to Git
- Use Terraform Cloud for sensitive variables
- Use Azure Key Vault for application secrets

### GitIgnore Configuration

Terraform-specific files excluded from Git:
```
.terraform/           # Provider plugins and modules
.terraform.lock.hcl   # Dependency lock file
*.tfstate            # State files (contain sensitive data)
*.tfstate.*          # State backups
*.tfvars             # Variable files (may contain secrets)
```

## Deployment

### Prerequisites

- Azure subscription
- Terraform Cloud account and organization
- Azure CLI installed
- Appropriate permissions in Azure

### Manual Deployment

```bash
# Navigate to infrastructure directory
cd documentation/infra

# Initialize Terraform
terraform init

# Plan changes
terraform plan

# Apply changes
terraform apply
```

### Automated Deployment

The CI/CD pipeline automatically deploys infrastructure:

1. **Terraform Cloud Authentication**
   - Pipeline uses team token stored in `TERRAFORM_CLOUD_TOKEN`
   - Token configured as Azure DevOps secret variable

2. **Deployment Process**
   - Runs on every commit to `main`
   - Executes in parallel with documentation build
   - Must succeed before documentation deployment

See [CI/CD Pipelines](../pipelines/index.md) for details.

## Infrastructure as Code Best Practices

### Module Design

- **Reusability** - Create modules for common patterns
- **Composition** - Combine modules for complete environments
- **Versioning** - Tag module versions for stability
- **Documentation** - Document inputs, outputs, and usage

### State Management

- **Remote State** - Always use remote backend (Terraform Cloud)
- **State Locking** - Prevent concurrent modifications
- **Sensitive Data** - Mark outputs as sensitive when appropriate
- **Workspaces** - Use for environment separation

### Security

- **Least Privilege** - Grant minimum required permissions
- **Secrets Management** - Never store secrets in code
- **Network Security** - Use private endpoints where possible
- **Compliance** - Follow organizational security policies

## Azure Resources

### Resource Naming Convention

Format: `{resource-type}-{project}-{environment}`

Examples:
- Storage: `stplatformdocstest`
- Front Door: `fd-platformdocs-test`
- Resource Group: `rg-platformdocs-test`
- App Service Plan: `asp-test`

### Tagging Strategy

All resources should include tags:
```hcl
tags = {
  Environment = "test"
  Project     = "blog-platform"
  ManagedBy   = "terraform"
}
```

## Cost Management

### Optimization Strategies

1. **Right-Sizing** - Choose appropriate SKUs for each environment
2. **Auto-Scaling** - Scale based on demand
3. **Resource Cleanup** - Remove unused resources
4. **Reserved Instances** - Commit for production workloads
5. **Monitoring** - Track costs with Azure Cost Management

### Cost by Environment

- **Test/Dev** - Lower SKUs, can be shut down when not in use
- **Production** - Appropriate sizing for performance and reliability

## Monitoring and Observability

### Built-in Monitoring

Azure resources include:
- **Azure Monitor** - Metrics and logs
- **Application Insights** - Application performance monitoring
- **Front Door Analytics** - CDN performance and security

### Health Checks

- Application health endpoints
- Azure Front Door health probes
- Service-level monitoring

## Disaster Recovery

### Backup Strategy

- **State Files** - Backed up in Terraform Cloud
- **Application Data** - Regular database backups
- **Configuration** - Stored in Git

### Recovery Procedures

1. State recovery from Terraform Cloud
2. Infrastructure recreation via `terraform apply`
3. Application redeployment via CI/CD pipeline
