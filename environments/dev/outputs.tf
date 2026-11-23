output "dev_resource_group_name" {
  value = azurerm_resource_group.dev_rg.name
}

output "dev_storage_endpoint" {
  value = azurerm_storage_account.dev_sa.primary_blob_endpoint
}
