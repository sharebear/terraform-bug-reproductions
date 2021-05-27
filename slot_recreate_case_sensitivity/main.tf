terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.59.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

variable "prefix" {
  type    = string
  default = "js"
}

resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-slot-test-rg"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "this" {
  name                = "${var.prefix}-slot-test-plan"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "this" {
  name                = "${var.prefix}-slot-test-app"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  app_service_plan_id = azurerm_app_service_plan.this.id

  https_only = true

  site_config {
    ftps_state       = "Disabled"
    linux_fx_version = "NODE|14-lts"
  }

}


resource "azurerm_app_service_slot" "this" {
  name                = "a-slot"
  app_service_name    = azurerm_app_service.this.name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  app_service_plan_id = azurerm_app_service_plan.this.id

  # https_only = true

}

output "app_service_plan_id" {
  value = azurerm_app_service_plan.this.id
}


