# Development Environment Blueprint following Cloud Adoption Framework (CAF) naming:
# [resource_type]-[project]-[environment]-[region]
resource "azurerm_resource_group" "dev_rg" {
  name     = "rg-${var.project_code}-${var.environment}-${var.location}"
  location = var.location
  tags = {
    Environment = "Development"
    CostCenter  = "Engineering-Dev"
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_storage_account" "dev_sa" {
  name                     = "st${var.project_code}${var.environment}data01"
  resource_group_name      = azurerm_resource_group.dev_rg.name
  location                 = azurerm_resource_group.dev_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}
