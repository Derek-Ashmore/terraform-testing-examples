variable vnet_name {
    description = "Name of the virtual network"
    type        = string
}

variable vnet_cidr_list {
    description = "List of CIDR blocks to use for the virtual network"
    type        = list(string)
}

variable location {
    description = "Azure region to deploy the virtual network"
    type        = string
}

variable resource_group_name {
    description = "Name of the resource group to deploy the virtual network"
    type        = string
}

variable subnet_config {
    description = "Subnet specification for the virtual network"
    type        = map(object({
        address_prefixes                                = list(string)
        enforce_private_link_endpoint_network_policies  = optional(bool, null)
    }))
}

variable tags {
    description = "Tags to apply to the virtual network"
    type        = map(string)
    default     = {}
}
