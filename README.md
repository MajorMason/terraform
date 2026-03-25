# Terraform Azure PaaS Infrastructure

This repository contains Terraform code for deploying a secure, modular PaaS application architecture on Microsoft Azure.
The main deployment provisions frontend and backend Azure Container Apps, an Azure SQL Database instance, and a private virtual network to ensure controlled access and isolation between components.

---

## 📘 Overview

The infrastructure is designed around a containerized PaaS application with strict network boundaries. Frontend services are publicly accessible, while backend services and the database remain fully private via private endpoints.

### Key Components

- **Azure Container Apps**
  - **Frontend container apps** deployed in private subnet with public ingress enabled
  - **Backend container api** deployed in private subnet with no public ingress enabled, and leverages a private endpoint
- **Azure SQL Database**
  - Private endpoint only
  - Accessible exclusively by backend container api
- **Virtual Network**
  - Private subnet for container apps and SQL
  - Segregated networking to enforce least-privilege access via private endpoints where needed
- **Modular Terraform Structure**
  - Reusable modules for container apps, networking, and database provisioning
