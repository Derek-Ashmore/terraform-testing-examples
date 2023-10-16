## Test Execution

Executing tests is as simple as setting your directory to the module you want to test and executing the following command:

'''
az login
terraform init
terraform test -verbose
'''

> The ```verbose``` is optional.
I like it as it shows the reources create in each ```run``` block, which makes coding assertions easier.

> Before executing tests, you must log into your cloud provider.
For example, before testing an Azure module test, I need to issue ```az login``` as the users credentials are used in these examples.

Refer to the [documentation](https://developer.hashicorp.com/terraform/cli/commands/test) for additional detail.