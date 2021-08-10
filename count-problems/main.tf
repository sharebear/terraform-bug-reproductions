provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  # count    = 1
  name     = "can-i-count-rg"
  location = "westeurope"
}
