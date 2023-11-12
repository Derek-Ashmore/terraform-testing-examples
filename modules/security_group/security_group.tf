resource "azurerm_network_security_group" "security_group" {
  name                  = var.security_group_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  tags                  = var.tags
}

resource "azurerm_network_security_rule" "security_group_rule" {
  for_each = var.rule_config

  resource_group_name         = azurerm_network_security_group.security_group.resource_group_name
  network_security_group_name = azurerm_network_security_group.security_group.name

  name                        = each.key
  priority                    = each.value.priority
  protocol                    = each.value.protocol
  direction                   = each.value.direction
  access                      = each.value.access
  description                 = each.value.description

  source_port_range                       = each.value.source_port_range
  source_port_ranges                      = each.value.source_port_ranges
  source_address_prefix                   = each.value.source_address_prefix
  source_address_prefixes                 = each.value.source_address_prefixes
  source_application_security_group_ids   = each.value.source_application_security_group_ids

  destination_port_range                      = each.value.destination_port_range
  destination_port_ranges                     = each.value.destination_port_ranges
  destination_address_prefix                  = each.value.destination_address_prefix
  destination_address_prefixes                = each.value.destination_address_prefixes
  destination_application_security_group_ids  = each.value.destination_application_security_group_ids

}
