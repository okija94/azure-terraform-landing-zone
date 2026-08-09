# Azure Terraform Landing Zone

A modular Azure Landing Zone built with Terraform to demonstrate Infrastructure as Code (IaC), Azure networking, monitoring, governance, security, storage, and data services.

## Architecture

![Azure Terraform Landing Zone Architecture](docs/landingzone_diagram_cleaned.png)

## Overview

This project provisions an Azure landing zone across four dedicated resource groups:

- **network-group** – Virtual networks, subnets, and network governance
- **logging-group** – Centralized Log Analytics workspace
- **storage-group** – Data engineering storage resources
- **security-group** – Security monitoring, Key Vault, Storage Account, and Azure SQL resources

## Networking

### Hub VNet

- `hub-vnet` – `10.0.0.0/16`

Reserved infrastructure subnets:

- `AzureFirewallSubnet` – `10.0.3.0/26`
- `appgateway-subnet` – `10.0.2.0/24`
- `AzureBastionSubnet` – `10.0.4.0/26`

### Application VNet

- `app-vnet` – `10.1.0.0/16`

Workload subnets:

- `web-subnet` – `10.1.1.0/24`
- `app-subnet` – `10.1.2.0/24`

Network Security Groups (NSGs) are applied to workload subnets to control inbound traffic.

## Monitoring

Two Log Analytics workspaces are deployed:

- `central-log-workspace`
- `security-log-workspace`

## Storage

### Security Storage

- StorageV2
- Standard LRS
- Hierarchical Namespace Disabled

### Data Engineering Storage

- StorageV2
- Standard LRS
- Hierarchical Namespace Enabled (Data Lake Gen2)

## Security and Governance

The landing zone includes:

- Azure Key Vault
- Azure Policy
- Network Security Groups
- Resource Tagging

Azure Policy is assigned to restrict allowed network resource types within the network resource group.

## Data Platform

Two Azure SQL environments are configured:

- `centralserver`
- `engserver`

Both are deployed using the S0 SKU.

## Terraform Module Structure

```text
modules/
├── general/
│   └── resourcegroup/
├── networking/
│   └── vnet/
├── monitoring/
│   └── logging/
├── storage/
│   ├── azurestorage/
│   └── sqldatabases/
├── security/
└── governance/
    └── policy/
```

## Skills Demonstrated

- Terraform Module Design
- Infrastructure as Code (IaC)
- Azure Landing Zone Architecture
- Azure Networking
- Network Segmentation
- Azure Policy Governance
- Azure Monitor & Log Analytics
- Azure Storage & Data Lake Gen2
- Azure Key Vault
- Azure SQL
- Resource Tagging and Governance