
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

    tags = {
        first = "fred"
        second = "flintstone"
    }
}

run "setup" {
    module {
      source = "../../test-setup/resource_group"

    }
    /* 
      Variable inputs to modules modules used in the test setup aren't allowed.
        This makes it difficult to genericize common test setup code.
    */
}

run "first_plan" {
    command = plan
    variables {
      vnet_name = "Test-VNet"
      vnet_cidr_list = ["10.1.0.0/16"]
      subnet_config = {
        subnet1 = {
          address_prefixes = ["10.1.1.0/24"]
        }
      }
    }
}