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