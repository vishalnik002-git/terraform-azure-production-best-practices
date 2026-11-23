# 🏛️ Enterprise Cloud Architecture & Production Concepts

## 1. High-Level Design (HLD) vs Low-Level Design (LLD)
- **High-Level Design (HLD)**:
  Focuses on macro architecture: system topologies, network perimeters, cloud boundary definitions, cross-region disaster recovery, and data flow between microservices. Intended for Enterprise Architects and stakeholders.
- **Low-Level Design (LLD)**:
  Focuses on implementation specifics: subnet IP CIDR sizing, Terraform module interfaces, Azure RBAC roles, encryption key rotation, and exact resource argument values. Intended for DevOps and Cloud Engineers.

---

## 2. Cloud Migration & Application Modernization
- **Rehost (Lift and Shift)**: Moving on-premises VMs to Azure IaaS Virtual Machines with minimal changes.
- **Replatform (Lift, Tinker, and Shift)**: Moving to managed PaaS services (e.g. Azure App Service, Azure SQL Managed Instance) to reduce OS maintenance.
- **Refactor / Re-architect**: Redesigning legacy monolithic applications into containerized microservices running on Azure Kubernetes Service (AKS) or Azure Container Apps with serverless functions.

---

## 3. Monolithic vs Microservices Infrastructure
- **Monolithic IaC**:
  Storing all networking, compute, database, and storage resources in a single giant `main.tf`.
  *Disadvantages*: Massive blast radius, slow `terraform plan` times, and frequent state locking conflicts.
- **Microservices / Decoupled IaC**:
  Splitting infrastructure into independent lifecycle boundaries (e.g. Core Network -> Database Cluster -> App Services). Each boundary maintains its own state file and deployment pipeline.

---

## 4. Zero-Downtime Deployment Strategies
- **Blue / Green Deployments**:
  Maintaining two identical production environments. The router directs traffic to "Blue" while "Green" is updated and verified. Traffic is then flipped instantaneously.
- **Canary Releases**:
  Rolling out changes to a small percentage of users (e.g. 5%) first, monitoring error rates, and progressively routing all traffic if metrics remain healthy.

---

## 5. The Microsoft Azure Resource Hierarchy
Azure organizes cloud assets into four hierarchical levels of scope:
```
  [ 1. Management Groups ]   --> Organization-wide governance & Azure Policy
             |
             v
  [ 2. Subscriptions ]       --> Billing boundary, quota management & access control
             |
             v
  [ 3. Resource Groups ]      --> Lifecycle & logical deployment boundary
             |
             v
  [ 4. Resources ]           --> VMs, Storage Accounts, VNets, Databases
```
