module "vnet" {
    source              = "../../modules/vnet"

    resource_group_name = azurerm_resource_group.resource_group.name
    location            = var.location
    vnet_name           = var.vnet_name
    vnet_cidr_list      = var.vnet_cidr_list
    subnet_config       = var.subnet_config
    tags                = var.tags
}