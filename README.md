# terraform-testing-examples
Examples for Terraform Testing Framework.

Example modules (with tests) are procided in the ```modules``` folder.

Notes on executing tests are [here](./modules/Test-Execution.md)

## Observations
* Test run time for even bassic tests is long. You want to invest in running tests automatically via CI/CD pipeline so that a human doesn't have to wait.
* Error message text in assertions only support very basic variables. Makes figuring out why a test failed difficult sometimes.
* I haven't found a good way to test module output values
* Interrogating complex attributes (e.g. Azure subnet delegations) are not easy or obvious.
* Multi-line conditions in test assertions are *not* supported. Conditions must be one and only one line.
* Variable inputs to modules used in the test setup aren't allowed. This makes it difficult to genericize common test setup code.
* Github workflows to automatically run tests were very easy to set up. See [our local workflow](.github/workflows/test-all-modules.yml)


## Module Inventory

| Name | Test Code | Description |
|--- |--- |--- |
| [```vnet```](modules/vnet/README.md) | [```test_suite.tftest.hcl```](modules/vnet/test_suite.tftest.hcl) | Defines a VNet, subnets, along with any needed delegations and service endpoints. |

## Resources

Chief resoruces used for this development are:
* [Terraform test code documentation](https://developer.hashicorp.com/terraform/language/tests)
* [Terraform test command options](https://developer.hashicorp.com/terraform/cli/commands/test)