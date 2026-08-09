# Azure Terraform Landing Zone

## Architecture

![Azure Terraform Landing Zone](docs/landingzone_diagram_cleaned.png)

## Overview

This project provisions an Azure landing zone across four dedicated resource groups:

- **network-group** – Virtual networks, subnets, NSG controls, and network governance
- **logging-group** – Central Log Analytics workspace
- **storage-group** – Data engineering Storage Account with hierarchical namespace enabled
- **security-group** – Security Log Analytics workspace, Storage Account, Key Vault, and Azure SQL environments

## Networking

### Hub VNet

`hub-vnet` – `10.0.0.0/16`

Reserved infrastructure subnets:

- `AzureFirewallSubnet` – `10.0.3.0/26`
- `appgateway-subnet` – `10.0.2.0/24`
- `AzureBastionSubnet` – `10.0.4.0/26`

### Application VNet

`app-vnet` – `10.1.0.0/16`

Workload subnets:

- `web-subnet` – `10.1.1.0/24`
- `app-subnet` – `10.1.2.0/24`

The workload subnets are associated with an NSG containing inbound rules for:

- TCP 80
- TCP 22

## Monitoring

Two Log Analytics workspaces are deployed:

- `central-log-workspace` in `logging-group`
- `security-log-workspace` in `security-group`

## Storage

### Security Storage

- StorageV2
- Standard LRS
- Hierarchical namespace disabled
- Deployed to `security-group`

### Data Engineering Storage

- StorageV2
- Standard LRS
- Hierarchical namespace enabled
- Deployed to `storage-group`

## Security and Governance

The landing zone includes:

- Azure Key Vault
- Azure Policy
- Network Security Groups
- Resource tagging

The network resource group has an Azure Policy assignment restricting allowed resource types.

## Data Platform

Two Azure SQL environments are configured in `security-group`:

- `centralserver`
- `engserver`

Both use the S0 SKU.

## Terraform

The infrastructure is organized into reusable Terraform modules to separate concerns such as:

- Resource groups
- Networking
- Monitoring
- Storage
- Security
- SQL
- Governance

## Deployment

Initialize Terraform:

```bash
terraform init