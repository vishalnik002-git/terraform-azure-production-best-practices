# 🏛️ Production Best Practices, Enterprise Architecture & Azure Governance

![Terraform Version](https://img.shields.io/badge/Terraform-1.5%2B-blue.svg?logo=terraform)
![Azure Provider](https://img.shields.io/badge/AzureRM-3.100%2B-0078D4.svg?logo=microsoft-azure)
![IaC](https://img.shields.io/badge/IaC-Best%20Practices-623CE4.svg)
![Validation](https://img.shields.io/badge/Validation-Pass-success.svg)

> **Repository 08 of 08 in the Terraform + Microsoft Azure Professional Learning Series (Capstone)**

---

## 📌 Navigation
| ⏪ Previous Repository | 📚 Current Repository | ⏩ Next Repository |
| :--- | :---: | :--- |
| [← 07. terraform-azure-modules-and-reuse](https://github.com/vishalnik002-git/terraform-azure-modules-and-reuse) | **08. terraform-azure-production-best-practices** | *None (Capstone Complete)* |

---

## 📖 Project Overview

Writing syntactically valid Terraform code is only the first step. Operating cloud infrastructure at scale requires strict adherence to **enterprise design principles**, **consistent naming conventions**, **environment isolation**, and **cloud governance frameworks**.

This capstone repository synthesizes all previous modules into production-grade patterns:
- **Cloud Adoption Framework (CAF) Naming Conventions**.
- **Strict Environment Separation** (`dev/` vs `prod/`).
- **Microsoft Azure Hierarchy** (Management Groups → Subscriptions → Resource Groups → Resources).
- **Architecture Documentation**: High-Level Design (HLD) vs Low-Level Design (LLD), Cloud Migration, Monolithic vs Microservices IaC, and Zero-Downtime deployments.

> ℹ️ **Learning Note**: This repository contains architectural blueprints and design documentation. Automated validation checks verify HCL syntax without provisioning live Azure cloud resources.

---

## 🎯 Learning Objectives

By exploring this repository, you will understand:
1. Standardized resource naming conventions (`[resource_type]-[workload]-[env]-[region]`).
2. Why Production and Development environments must maintain isolated directories and state backends.
3. How Microsoft Azure structures governance across Management Groups, Subscriptions, and Resource Groups.
4. The difference between High-Level Architecture (HLD) and Implementation Specs (LLD).
5. Cloud modernization patterns: Rehosting, Replatforming, and Refactoring into microservices.
6. Zero-downtime deployment patterns (Blue/Green and Canary) in cloud infrastructure.

---

## 🏢 Azure Governance Hierarchy

```
+-------------------------------------------------------------------------+
|                  Microsoft Azure Management Hierarchy                   |
+-------------------------------------------------------------------------+
                                     |
                                     v
                        [ Root Management Group ]
                                     |
          +--------------------------+--------------------------+
          |                                                     |
          v                                                     v
 [ Enterprise MG (Core) ]                            [ Workloads MG (Apps) ]
          |                                                     |
          v                                                     v
 [ Subscription: Platform ]                         [ Subscription: Production ]
          |                                                     |
          v                                                     v
 [ Resource Group: rg-hub-eastus ]                  [ Resource Group: rg-ops-prod-eastus ]
          |                                                     |
          v                                                     v
 [ Virtual Networks, Firewalls ]                     [ Storage Accounts, Compute, DBs ]
```

---

## 📂 Repository Structure

```
terraform-azure-production-best-practices/
├── .github/
│   └── workflows/
│       └── validate.yml          # GitHub Actions CI validation pipeline
├── docs/
│   └── architecture-concepts.md  # Architectural deep-dive: HLD, LLD, Migration, Microservices
├── environments/
│   ├── dev/                      # Isolated Development environment blueprint
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── terraform.tfvars.example
│   │   ├── variables.tf
│   │   └── versions.tf
│   └── prod/                     # Isolated Production environment blueprint
│       ├── main.tf
│       ├── outputs.tf
│       ├── terraform.tfvars.example
│       ├── variables.tf
│       └── versions.tf
├── .gitignore                    # Standard exclusion rules
├── main.tf                       # Root module metadata
├── outputs.tf                    # Root outputs
├── providers.tf                  # AzureRM provider configuration
├── versions.tf                   # Version constraint declarations
└── README.md                     # Comprehensive documentation
```

---

## 🏆 Production Best Practice Checklist

1. **Tagging Policy**: Enforce mandatory metadata tags on all resources (`Environment`, `CostCenter`, `ManagedBy`).
2. **Version Pinning**: Always pin both the Terraform CLI version (`>= 1.5.0`) and the provider version (`~> 3.100.0`) in `versions.tf`.
3. **Remote State Locking**: Never run production workloads with local state. Store state in Azure Blob Storage with lease locking.
4. **Environment Isolation**: Keep `dev`, `stage`, and `prod` in separate directories or workspaces with distinct state files to prevent accidental cross-environment blast radius.
5. **No Hardcoded Secrets**: Use Azure Key Vault or environment variables for sensitive parameters.
6. **Automated CI Linting**: Execute `terraform fmt -check` and `terraform validate` on every pull request.

---

## 🛠️ Step-by-Step Getting Started Guide

### Prerequisites
- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) (v1.5.0+).

### 1. Validate Development Environment
```bash
cd environments/dev
terraform fmt -check
terraform init -backend=false
terraform validate
```

### 2. Validate Production Environment
```bash
cd ../prod
terraform fmt -check
terraform init -backend=false
terraform validate
```

---

## 🔄 Terraform Resource Lifecycle & Destruction Concepts

1. **Zero Downtime Updates**:
   Certain argument changes in Azure (e.g. changing Storage Account SKU or Resource Group name) force recreation (`-/+`). In production, this can cause service interruptions. Always verify whether a plan indicates in-place update (`~`) or destroy-and-recreate (`-/+`).
2. **Resource Locks**:
   In production Azure subscriptions, configure Azure Resource Locks (`CanNotDelete` / `ReadOnly`) on critical Resource Groups to prevent accidental deletion even if an erroneous `terraform destroy` command is executed.

---

## 🤖 CI/CD Automation (GitHub Actions)

This repository includes a continuous integration workflow in `.github/workflows/validate.yml` that validates syntax across the root workspace and both the `dev/` and `prod/` environment configurations on every push and pull request.

---

## 👨‍💻 Author Information

- **Developer**: Vishal Yadav (`vishalnik002-git`)
- **Education**: MCA @ Galgotias University (2025–2027) | BCA @ MGKVP (2022–2025)
- **Role**: DevOps Intern @ DevOps Insiders
- **GitHub Profile**: [https://github.com/vishalnik002-git](https://github.com/vishalnik002-git)
