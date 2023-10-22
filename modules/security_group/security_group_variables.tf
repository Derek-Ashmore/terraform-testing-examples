variable security_group_name {
    description = "Name of the security group"
    type        = string
}

variable location {
    description = "Azure region"
    type        = string
}

variable resource_group_name {
    description = "Name of the resource group"
    type        = string
}

variable tags {
    description = "Resource tags"
    type        = map(string)
    default     = {}
}