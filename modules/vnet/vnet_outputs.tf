output azurerm_virtual_network {
    value = azurerm_virtual_network.vnet
    description = "azurerm_virtual_network resource"
}

output azurerm_subnet {
    value = azurerm_subnet.subnet
    description = "List of azurerm_subnet resources created"
}