resource "azurerm_route_table" "route_table" {
  name                          = var.route_table_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
}

output azurerm_route_table {
  value = azurerm_route_table.route_table
  description = "Route table AzureRM object"
}