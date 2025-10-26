# CI/CD Pipelines

## Overview

The project uses Azure DevOps pipelines for continuous integration and deployment. Pipelines are defined in the `.azdo/` directory and automate the build, test, and deployment processes.

## Pipeline Structure

### Documentation Pipeline

**File:** `.azdo/documentation.yml`

This pipeline builds and deploys the documentation site to Azure.

#### Trigger Configuration

```yaml
trigger:
  branches:
    include:
      - main
  paths:
    include:
      - documentation/docs/**
      - documentation/mkdocs.yml
      - .azdo/documentation.yml
```

Only triggers when documentation-related files change.

#### Pipeline Stages

**1. Build Stage**
- Installs Node.js 24.x
- Installs TechDocs CLI globally
- Generates static documentation site
- Publishes documentation artifact

**2. Deploy Infrastructure Stage** (Runs in parallel with Build)
- Installs Terraform CLI
- Configures Terraform Cloud credentials
- Initializes Terraform configuration
- Applies infrastructure changes

**3. Deploy Stage** (Depends on both Build and Deploy Infrastructure)
- Downloads documentation artifact
- Deploys to Azure Storage:
  - Deletes old files
  - Uploads new files to `$web` container
- Purges Azure Front Door CDN cache

#### Variables

```yaml
variables:
  - name: storageAccount
    value: 'stplatformdocstest'
  - name: containerName
    value: '\$web'
  - name: TF_CLOUD_TOKEN
    value: '$(TERRAFORM_CLOUD_TOKEN)'
```

#### Required Secrets

Set these as pipeline variables in Azure DevOps:

- **TERRAFORM_CLOUD_TOKEN** - Team token from Terraform Cloud
- **Azure Service Connection** - Named `documentation`

## Service Connections

### Azure Service Connection

**Name:** `documentation`

**Type:** Azure Resource Manager

**Required Permissions:**
- Storage Account Contributor (for blob operations)
- CDN Profile Contributor (for Front Door purge)

### Creating the Service Connection

1. Navigate to Azure DevOps Project Settings
2. Select "Service connections"
3. Create new "Azure Resource Manager" connection
4. Choose "Service Principal (automatic)"
5. Select subscription and resource group
6. Name it `documentation`

## Terraform Cloud Integration

### Setup

1. **Create Terraform Cloud Account**
   - Sign up at [app.terraform.io](https://app.terraform.io)

2. **Create Organization**
   - Create or join an organization

3. **Create Workspace**
   - Name: `blog-platform-docs`
   - Type: API-driven workflow

4. **Generate Team Token**
   - Navigate to Organization Settings > Teams
   - Create or select a team
   - Generate a team API token

5. **Add Token to Pipeline**
   - In Azure DevOps, go to Pipeline > Edit
   - Add variable `TERRAFORM_CLOUD_TOKEN`
   - Mark as secret
   - Paste the team token

### Token Security

- **Never commit tokens** to source control
- **Use Azure DevOps Secrets** for secure storage
- **Rotate tokens** periodically
- **Limit token permissions** to required teams

## Pipeline Execution

### Automatic Triggers

Pipelines run automatically when:
- Changes are pushed to `main` branch
- Changed files match the path filters

### Manual Runs

To run manually:
1. Navigate to Pipelines in Azure DevOps
2. Select the pipeline
3. Click "Run pipeline"
4. Select branch and parameters

### Parallel Execution

The pipeline is optimized for parallel execution:

```
┌─────────────┐
│   Trigger   │
└──────┬──────┘
       │
       ├──────────────────┬──────────────────┐
       ▼                  ▼                  │
┌────────────┐    ┌──────────────┐         │
│   Build    │    │ Deploy Infra │         │
└──────┬─────┘    └──────┬───────┘         │
       │                 │                  │
       └────────┬────────┘                  │
                ▼                           │
         ┌────────────┐                     │
         │   Deploy   │                     │
         └────────────┘                     │
```

Build and Deploy Infrastructure run concurrently, reducing overall pipeline time.

## Best Practices

### Pipeline Configuration

1. **Use YAML Pipelines** - Version controlled with code
2. **Modular Stages** - Separate concerns (build, test, deploy)
3. **Parallel Jobs** - Maximize efficiency
4. **Artifact Management** - Publish and download between stages

### Security

1. **Secret Management**
   - Use Azure DevOps variable groups
   - Mark sensitive variables as secret
   - Never log secrets

2. **Service Principals**
   - Use least-privilege access
   - Rotate credentials regularly
   - Monitor service principal usage

3. **Code Scanning**
   - Scan for secrets in code
   - Validate Terraform configurations
   - Check for vulnerabilities

### Deployment Strategies

1. **Staged Deployments**
   - Deploy to test environment first
   - Require approval for production
   - Use deployment gates

2. **Rollback Capability**
   - Keep previous versions
   - Automate rollback process
   - Test rollback procedures

3. **Blue-Green Deployments**
   - Deploy to inactive slot
   - Swap when validated
   - Quick rollback by swapping back

## Monitoring Pipelines

### Pipeline Analytics

Azure DevOps provides:
- Run history and trends
- Success/failure rates
- Duration analysis
- Resource usage

### Notifications

Configure notifications for:
- Pipeline failures
- Successful deployments
- Approval requests
- Long-running pipelines

### Logging

Each pipeline step logs output:
- View in real-time during execution
- Review historical logs
- Download for analysis

## Troubleshooting

### Common Issues

**1. Authentication Failures**
```
Error: Unable to authenticate to Azure
```
**Solution:** Check service connection configuration and permissions

**2. Terraform Cloud Connection**
```
Error: credentials "app.terraform.io"
```
**Solution:** Verify TERRAFORM_CLOUD_TOKEN is set correctly

**3. Storage Account Access**
```
Error: The specified container does not exist
```
**Solution:** Ensure infrastructure is deployed before documentation

**4. Front Door Purge Failures**
```
Error: Resource not found
```
**Solution:** Verify Front Door resource names match configuration

### Debugging Tips

1. **Enable Verbose Logging**
   - Add `--verbose` or `--debug` flags
   - Review detailed output

2. **Run Locally**
   - Test scripts locally before committing
   - Use same commands as pipeline

3. **Check Dependencies**
   - Verify all required tools are installed
   - Check version compatibility

4. **Review Recent Changes**
   - Compare with last successful run
   - Check for configuration changes

## Pipeline Maintenance

### Regular Tasks

- **Update Dependencies** - Keep tools and packages current
- **Review Logs** - Check for warnings or deprecated features
- **Test Pipelines** - Regularly verify functionality
- **Update Documentation** - Keep pipeline docs current

### Version Pinning

Pin versions for stability:
- Terraform CLI version
- Node.js version
- Task versions in pipeline YAML

Example:
```yaml
- task: NodeTool@0
  inputs:
    versionSpec: '24.x'  # Pin to major version
```

## Future Enhancements

Potential improvements:
- **Multi-stage approvals** for production deployments
- **Integration tests** in pipeline
- **Security scanning** integration
- **Performance testing** automation
- **Automated rollback** on failure detection
