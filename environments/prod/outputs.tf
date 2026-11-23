output "prod_resource_group_name" {
  value = azurerm_resource_group.prod_rg.name
}

output "prod_storage_endpoint" {
  value = azurerm_storage_account.prod_sa.primary_blob_endpoint
}
