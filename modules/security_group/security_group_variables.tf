variable security_group_name {
    description = "Name of the security group"
    type        = string
}

variable location {
    description = "Azure region"
    type        = string
}

variable resource_group_name {
    description = "Resoruce group name"
    type        = string
}

variable tags {
    description = "Resource tags"
    type        = map(string)
    default     = {}
}

variable rule_config {
    description = "Security group rules"
    type        = map(object({
        priority                    = number
        protocol                    = string
        direction                   = string
        access                      = string
        description                 = optional(string, null)

        source_port_range                       = optional(string, null)
        source_port_ranges                      = optional(list(string), null)
        source_address_prefix                   = optional(string, null)
        source_address_prefixes                 = optional(list(string), null)
        source_application_security_group_ids   = optional(list(string), null)

        destination_port_range                      = optional(string, null)
        destination_port_ranges                     = optional(list(string), null)
        destination_address_prefix                  = optional(string, null)
        destination_address_prefixes                = optional(list(string), null)
        destination_application_security_group_ids  = optional(list(string), null)
    }))
    default = {}
}