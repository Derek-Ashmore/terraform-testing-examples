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

variable route_table_name {
    description = "Name of the route table"
    type        = string
    default     = "testing-rg"
}