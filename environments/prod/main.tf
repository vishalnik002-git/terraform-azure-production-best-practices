# Production Environment Blueprint
# In production, enhanced redundancy (GRS/ZRS) and strict governance tags are enforced.
resource "azurerm_resource_group" "prod_rg" {
  name     = "rg-${var.project_code}-${var.environment}-${var.location}"
  location = var.location
  tags = {
    Environment = "Production"
    CostCenter  = "Mission-Critical"
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_storage_account" "prod_sa" {
  name                     = "st${var.project_code}${var.environment}data01"
  resource_group_name      = azurerm_resource_group.prod_rg.name
  location                 = azurerm_resource_group.prod_rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}
