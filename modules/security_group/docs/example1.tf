module "security_group" {
    source              = "../../modules/security_group"

    resource_group_name = azurerm_resource_group.resource_group.name
    location            = var.location
    security_group_name = var.security_group_name
    rule_config         = var.rule_config
    tags                = var.tags
}