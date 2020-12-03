# Issue reproduction https://github.com/hashicorp/terraform/issues/26959

## Prerequisites

* Terraform v0.13.5 (aliased as terraform13 here)
* Terraform v0.14.0 (aliased as terraform14 here)
* azure cli configured and authenticated

## Steps to reproduce

```
$ cd environments/dev
$ terraform13 init
$ terraform13 apply -auto-approve
$ terraform13 plan

# observe no changes

$ terraform14 init
$ terraform14 plan
```

My entire output from the last plan is 

```
module.base.azurerm_resource_group.main: Refreshing state... [id=/subscriptions/05db7780-2fb6-4d89-b19f-08b58574baba/resourceGroups/plugindev-resources]
module.base.azurerm_app_service_plan.main: Refreshing state... [id=/subscriptions/05db7780-2fb6-4d89-b19f-08b58574baba/resourceGroups/plugindev-resources/providers/Microsoft.Web/serverfarms/plugindev-asp]
module.base.azurerm_storage_account.main: Refreshing state... [id=/subscriptions/05db7780-2fb6-4d89-b19f-08b58574baba/resourceGroups/plugindev-resources/providers/Microsoft.Storage/storageAccounts/plugindevstorageacct]
module.application_x.azurerm_function_app.main: Refreshing state... [id=/subscriptions/05db7780-2fb6-4d89-b19f-08b58574baba/resourceGroups/plugindev-resources/providers/Microsoft.Web/sites/plugindev-function]

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  ~ update in-place

Terraform will perform the following actions:

  # module.application_x.azurerm_function_app.main will be updated in-place
  ~ resource "azurerm_function_app" "main" {
        id                             = "/subscriptions/05db7780-2fb6-4d89-b19f-08b58574baba/resourceGroups/plugindev-resources/providers/Microsoft.Web/sites/plugindev-function"
        name                           = "plugindev-function"
      + os_type                        = ""
      # Warning: this attribute value will be marked as sensitive and will
      # not display in UI output after applying this change
      ~ storage_account_access_key     = (sensitive value)
        tags                           = {}
        # (18 unchanged attributes hidden)



        # (3 unchanged blocks hidden)
    }

Plan: 0 to add, 1 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

```
