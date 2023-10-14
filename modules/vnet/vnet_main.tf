resource "azurerm_virtual_network" "vnet" {
    name                = var.vnet_name
    address_space       = var.vnet_cidr_list
    location            = var.location
    resource_group_name = var.resource_group_name

    tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
    for_each = var.subnet_config
    name                 = each.key
    resource_group_name  = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = each.value.address_prefixes

    private_endpoint_network_policies_enabled = each.value.private_endpoint_network_policies_enabled
}