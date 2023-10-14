<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.50 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.50 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | Azure region to deploy the virtual network | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group to deploy the virtual network | `string` | n/a | yes |
| <a name="input_subnet_config"></a> [subnet\_config](#input\_subnet\_config) | Subnet specification for the virtual network | <pre>map(object({<br>        address_prefixes                                = list(string)<br>        enforce_private_link_endpoint_network_policies  = optional(bool, null)<br>    }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the virtual network | `map(string)` | n/a | yes |
| <a name="input_vnet_cidr_list"></a> [vnet\_cidr\_list](#input\_vnet\_cidr\_list) | List of CIDR blocks to use for the virtual network | `list(string)` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name of the virtual network | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->