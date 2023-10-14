# terraform-testing-examples
Examples for Terraform Testing Framework.

Example modules (with tests) are procided in the ```modules``` folder.

Notes on executing tests are [here](./modules/Test-Execution.md)

## Observations
* Test run time for even bassic tests is long. You want to invest in running tests automatically via CI/CD pipeline so that a human doesn't have to wait.
* Error message text in assertions only support very basic variables. Makes figuring out why a test failed difficult sometimes.
* I haven't found a good way to test module output values