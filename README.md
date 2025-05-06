# Azure DevOps Showcase: Three-Tier App Deployment Pipeline

## Overview

This project demonstrates a multi-region, blue-green deployment pipeline for a simplified three-tier Python application on Azure. It uses a combination of Bicep for shared infrastructure, Terraform for application components, and GitHub Actions for CI/CD. The purpose is to validate capability in designing, automating, and securing cloud infrastructure using Infrastructure as Code and DevOps best practices.

This is a mock setup intended as a skills demonstration. Actual deployment steps and runtime actions are simulated due to Azure permission limitations.

## Technologies

- **Azure Bicep** – for base infrastructure (hub-spoke network, Key Vault, Log Analytics)
- **Terraform** – for application-tier resources (AKS, Application Gateway, Cosmos DB)
- **GitHub Actions** – for CI/CD automation
- **Traffic Manager (simulated)** – for blue-green routing
- **Terratest (simulated)** – for region-based integration testing
- **Canada Central** and **East US 2** – as primary and secondary regions


## GitHub Actions Pipeline

### Job 1: Lint & Validate
- Terraform: `fmt`, `validate`, `tflint`
- Bicep: `build`, `what-if` (simulated)
- OIDC login (commented, prepared for real deployment)

### Job 2: Integration Testing (Simulated)
- Matrix strategy for multi-region (`canadacentral`, `eastus2`)
- Simulates Terratest logic

### Job 3: Apply to Staging (Skipped)
- Would deploy via `terraform apply`
- Approval and OIDC flow omitted due to lack of App Registration access

### Job 4: Blue-Green Swap & E2E Test
- Simulates Traffic Manager promotion
- Runs a mock health check
- Includes conditional rollback on failure

## Assumptions and Simplifications

- No live Azure deployments due to App Registration restrictions
- Application Gateway, AKS, and Cosmos DB modules are valid and structured, but backend configuration is stubbed
- Traffic Manager actions are simulated via CLI echo commands
- SLO and rollback are represented by a test script with a forced failure

## Terraform modules

- **network**: Basic network module for hub-spoke architecture [(details)](./network/README.md)
- **aks**: AKS cluster module [(details)](./aks/README.md)
- **appgw**: Application Gateway module [(details)](./appgw/README.md)
- **cosmosdb**: Cosmos DB module [(details)](./cosmosdb/README.md)


## How to Use

```bash
# Validate Terraform modules
cd terraform
terraform init
terraform validate

# Build and validate Bicep templates
cd ../bicep
bicep build main.bicep

# Push to GitHub and observe CI pipeline
