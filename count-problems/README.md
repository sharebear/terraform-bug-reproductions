# Issue reproduction https://github.com/hashicorp/terraform/issues/29338

## Prerequisites

* Terraform v1.0.4 
* azure cli configured and authenticated

## Steps to reproduce

```
$ terraform init
$ terraform apply -auto-approve
$ terraform plan

# observe no changes
```

Uncomment line 6 in main.tf

```
$ terraform plan

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply":

  # azurerm_resource_group.main has been deleted
  - resource "azurerm_resource_group" "main" {
      - id       = "/subscriptions/<REDACTED>/resourceGroups/can-i-count-rg" -> null
      - location = "westeurope" -> null
      - name     = "can-i-count-rg" -> null
      - tags     = {} -> null
    }

Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using
ignore_changes, the following plan may include actions to undo or respond to these changes.

───────────────────────────────────────────────────────────────────────────────────────────────────────────

No changes. Your infrastructure matches the configuration.

Your configuration already matches the changes detected above. If you'd like to update the Terraform state
to match, create and apply a refresh-only plan:
  terraform apply -refresh-only
```

Note that the "Objects have changed outside of Terraform" warning appears to
imply that the resource has been removed while the plan correctly states that
there are no changes.

In this case the suggestion to run `apply -refresh-only` feels quite terrifying
as from the output as presented it looks like a running resource will be removed
from the state.

Running regular `apply` or `apply -refresh-only` does in-fact resolve the issue,
by adding the `"index_key": 0,` property to the state but it doesn't feel
natural or safe given the output of the command.

Making the change in the opposite direction exhibits similar behaviour.

While analysing this I see that the actualy behaviour is the same as in 0.14.x
but the "new" "Objects have changed outside of Terraform" is very misleading in
this case.
