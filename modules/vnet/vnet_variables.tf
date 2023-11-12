variable vnet_name {
    description = "Virtual network name"
    type        = string
}

variable vnet_cidr_list {
    description = "List of CIDR blocks to use for the virtual network"
    type        = list(string)
}

variable location {
    description = "Azure region"
    type        = string
}

variable resource_group_name {
    description = "Rresource group name"
    type        = string
}

variable subnet_config {
    description = "Subnet specification for the virtual network"
    type        = map(object({
        address_prefixes                                = list(string)
        private_endpoint_network_policies_enabled       = optional(bool, true)
        private_link_service_network_policies_enabled   = optional(bool, true)
        route_table_id                                  = optional(string, null)
        security_group_id                               = optional(string, null)
        delegations                                     = optional(map(object({
            name = string
            actions = optional(list(string))
        })), {})
        service_endpoints                               = optional(list(string), null)
    }))
}

variable tags {
    description = "resource tags"
    type        = map(string)
    default     = {}
}
