variable location {
    description = "Azure region"
    type        = string
    default     = "centralus"
}

variable resource_group_name {
    description = "Name of the resource group for the route table"
    type        = string
    default     = "testing-rg"
}

variable security_group_name {
    description = "Name of the security group"
    type        = string
    default     = "testing-security-group"
}