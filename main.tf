terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.50.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "azurerm" {
  features {}
  subscription_id = "c36a87c4-f51d-45b0-a152-4cbab9979e39"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-oficina"
  location = "eastus"
}

resource "azurerm_service_plan" "plan" {
  name                = "asp-oficina"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Windows"
  sku_name            = "F1"  # Plano gratuito
}

resource "azurerm_windows_web_app" "app" {
  name                = "app-oficina123" # Nome deve ser único no Azure
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    always_on = false
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}
