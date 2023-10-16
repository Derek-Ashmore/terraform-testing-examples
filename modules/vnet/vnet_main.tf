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

    private_endpoint_network_policies_enabled       = each.value.private_endpoint_network_policies_enabled
    private_link_service_network_policies_enabled   = each.value.private_link_service_network_policies_enabled
    service_endpoints                               = each.value.service_endpoints

    dynamic delegation {
        for_each = each.value.delegations
        content {
            name    = delegation.key
            service_delegation {
                name    = delegation.value.name
                actions = delegation.value.actions
            }
            

        }
    }
}

locals {
    subnet_route_table_map = {for k,v in var.subnet_config : k => v.route_table_id if v.route_table_id != null }
}
resource "azurerm_subnet_route_table_association" "subnet_route_table" {
    for_each        = local.subnet_route_table_map

    subnet_id       = azurerm_subnet.subnet[each.key].id
    route_table_id  = each.value
}

locals {
    subnet_security_group_map = {for k,v in var.subnet_config : k => v.security_group_id if v.security_group_id != null }
}

resource "azurerm_subnet_network_security_group_association" "subnet_security_group" {
    for_each                    = local.subnet_security_group_map

    subnet_id                   = azurerm_subnet.subnet[each.key].id
    network_security_group_id   = each.value
}