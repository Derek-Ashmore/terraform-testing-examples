# terraform-testing-examples
Examples for the Terraform Testing Framework released on October 4, 2023 with version 1.6.0.

Example modules (with tests) are provided in the ```modules``` folder.

Notes on executing tests are [here](./modules/Test-Execution.md)

## Observations
* Test run time for even bassic tests is long. You want to invest in running tests automatically via CI/CD pipeline so that a human doesn't have to wait.
* Error message text in assertions only support very basic variables. Makes figuring out why a test failed difficult sometimes.
* Interrogating complex attributes (e.g. Azure subnet delegations) are not easy or obvious.
* Multi-line conditions in test assertions are *not* supported. Conditions must be one and only one line.
* Variable inputs to modules used in the test setup are allowed, but do not follow the syntax you're used to. Variables are specified in "variable" blocks, not as arguments to the module call.
* Github workflows to automatically run tests were very easy to set up. See [our local workflow](.github/workflows/test-all-modules.yml)
* It would be nice if invalid resource references in test files errored out at the beginning. That would save time.
* True test-driven development (TDD) has finally arrived. It's wonderful!


## Module Inventory

| Name | Test Code | Description |
|--- |--- |--- |
| [```vnet```](modules/vnet/README.md) | [```test_suite.tftest.hcl```](modules/vnet/test_suite.tftest.hcl) | Defines a VNet, subnets, along with any needed delegations and service endpoints. Additionally, options for subnet route table and networksecurity group assignments are provided.|

## Resources

Chief resources used for this development are:
* [Terraform test code documentation](https://developer.hashicorp.com/terraform/language/tests)
* [Terraform test command options](https://developer.hashicorp.com/terraform/cli/commands/test)

## Product Roadmap

* Enhance workflow to asyncronously run tests
    * Current workflow won't scale as the number of modules included grow.
* Enhance module ```vnet``` documentation so I can use it as an example of module-writing best practices.
* Enhance workflow to automatically update documentation.