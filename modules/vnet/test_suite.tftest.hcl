
provider "azurerm" {
  features {}
} 
/*
  No other way to specify specific provider versions other than 
    to hardcode them into the module being tested.
  It *does* take the subscription and tenant from the Azure login context.
    We don't need to hardcode specific values for those.
*/

variables {
    resource_group_name     = "flintstone-vnet-rg"
    location                = "centralus"

    vnet_name               = "Test-VNet"
    vnet_cidr_list          = ["10.1.0.0/16"]

    tags = {
        first = "fred"
        second = "flintstone"
    }
}

/* 
      Variable inputs to modules use the variables block above for inputs.
        Not intuitive given normal module syntax, but it works.
*/
run "setup_rg" {
    module {
      source = "../../test-setup/resource_group"
    }
}

run "setup_route_table" {
    module {
      source = "../../test-setup/route_table"
    }
}

run "setup_security_group" {
    module {
      source = "../../test-setup/security_group"
    }
}

run "all_default_options" {
    variables {
      subnet_config = {
        subnet1 = {
          address_prefixes = ["10.1.1.0/24"]
        }
      }
    }

    // It's nice that error message support variables so that they can be more meaningful.
    assert {
      condition = azurerm_virtual_network.vnet.name == var.vnet_name
      error_message = "VNet name is not correct.  name=${azurerm_virtual_network.vnet.name}"
    }

    /* 
        Multi-line conditions are *not* supported.
        Complex variables in the error message have issues. 
          Putting the literal 'cidr=${join(",", azurerm_virtual_network.vnet.address_space}' in the error message did not work.
    */
    assert {
      condition = contains(azurerm_virtual_network.vnet.address_space, var.vnet_cidr_list[0]) && length(azurerm_virtual_network.vnet.address_space) == 1
      error_message = "VNet CIDR allocation is not correct."
    }
    assert {
      condition = contains(azurerm_subnet.subnet["subnet1"].address_prefixes, var.subnet_config["subnet1"].address_prefixes[0]) && length(azurerm_subnet.subnet["subnet1"].address_prefixes) == 1
      error_message = "Subnet CIDR is not correct."
    }

    assert {
      condition = length(azurerm_virtual_network.vnet.tags) == 2
      error_message = "VNet tags are not correct."
    }
    assert {
      condition = azurerm_virtual_network.vnet.tags["first"] == var.tags["first"] && azurerm_virtual_network.vnet.tags["second"] == var.tags["second"]
      error_message = "VNet tags are not correct."
    }

    /*
        Note how to reference tested module outputs. 
    */
    assert {
      condition = output.azurerm_virtual_network.id != null
      error_message = "VNet output not present."
    }
    assert {
      condition = output.azurerm_subnet["subnet1"].id != null
      error_message = "Subnet output not present."
    }

}

run "test_private_endpoint_network_policies_enabled" {
    variables {
      subnet_config = {
        subnet1 = {
          address_prefixes = ["10.1.1.0/24"]
          private_endpoint_network_policies_enabled = false
        }
      }
    }

    assert {
      condition = !azurerm_subnet.subnet["subnet1"].private_endpoint_network_policies_enabled
      error_message = "Subnet private_endpoint_network_policies_enabled is not correct."
    }
}

run "test_private_link_service_network_policies_enabled" {
    variables {
      subnet_config = {
        subnet1 = {
          address_prefixes = ["10.1.1.0/24"]
          private_link_service_network_policies_enabled = false
        }
      }
    }

    assert {
      condition = !azurerm_subnet.subnet["subnet1"].private_link_service_network_policies_enabled
      error_message = "Subnet private_endpoint_network_policies_enabled is not correct."
    }
    assert {
      condition = azurerm_subnet.subnet["subnet1"].private_endpoint_network_policies_enabled
      error_message = "Subnet private_endpoint_network_policies_enabled shoudl be true by default."
    }
}

run "test_service_endpoints" {
    variables {
      subnet_config = {
        subnet1 = {
          address_prefixes = ["10.1.1.0/24"]
          service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
        }
      }
    }

    assert {
      condition = length(azurerm_subnet.subnet["subnet1"].service_endpoints) == 2
      error_message = "Subnet service_endpoints are not correct. Wrong number of endpoints." 
    }
    assert {
      condition = contains(azurerm_subnet.subnet["subnet1"].service_endpoints, var.subnet_config["subnet1"].service_endpoints[0])
      error_message = "Subnet service_endpoint 1 missing." 
    }
    assert {
      condition = contains(azurerm_subnet.subnet["subnet1"].service_endpoints, var.subnet_config["subnet1"].service_endpoints[1])
      error_message = "Subnet service_endpoint 1 missing." 
    }
    assert {
      condition = azurerm_subnet.subnet["subnet1"].private_endpoint_network_policies_enabled
      error_message = "Subnet private_endpoint_network_policies_enabled shoudl be true by default."
    }
}

run "test_delegations" {
    variables {
      subnet_config = {
        subnet1 = {
          address_prefixes = ["10.1.1.0/24"]
          delegations = {
             aseDelegation = {
               name = "Microsoft.Web/serverFarms"
             }
          }
        }
      }
    }

    assert {
      condition = length(azurerm_subnet.subnet["subnet1"].delegation) == 1
      error_message = "Subnet delegation is missing." 
    }
    assert {
      condition = azurerm_subnet.subnet["subnet1"].delegation[0].name == "aseDelegation"
      error_message = "Subnet delegation aseDelegation is missing." 
    }
    assert {
      condition = azurerm_subnet.subnet["subnet1"].delegation[0].service_delegation[0].name == "Microsoft.Web/serverFarms"
      error_message = "Subnet delegation Microsoft.Web/serverFarms is missing." 
    }
    assert {
      condition = azurerm_subnet.subnet["subnet1"].private_endpoint_network_policies_enabled
      error_message = "Subnet private_endpoint_network_policies_enabled shoudl be true by default."
    }

}

/*
  Note that module outputs from previous run blocks can be referenced (e.g. run.setup_route_table.azurerm_route_table.id).
*/
run "test_route_table" {
    variables {
      subnet_config = {
        subnet1 = {
          address_prefixes = ["10.1.1.0/24"]
          route_table_id = run.setup_route_table.azurerm_route_table.id
        }
      }
    }

    assert {
      condition = azurerm_subnet_route_table_association.subnet_route_table["subnet1"].route_table_id == run.setup_route_table.azurerm_route_table.id
      error_message = "Subnet not associated with a route table as expected."
    }
}

run "test_security_group" {
    variables {
      subnet_config = {
        subnet1 = {
          address_prefixes = ["10.1.1.0/24"]
          security_group_id = run.setup_security_group.azurerm_network_security_group.id
        }
      }
    }

    assert {
      condition = azurerm_subnet_network_security_group_association.subnet_security_group["subnet1"].network_security_group_id == run.setup_security_group.azurerm_network_security_group.id
      error_message = "Subnet not associated with a security group as expected."
    }
}