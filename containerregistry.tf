provider "azurerm" {
  features {}
  subscription_id = ""

}

resource "azurerm_resource_group" "rg" {
  name     = "rg-acr"
  location = "brazilsouth"
}

resource "azurerm_container_registry" "acr" {
  name                = "acrregistryluiz"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

output "admin-usuario" {
  value = azurerm_container_registry.acr.admin_username
}

output "password" {
  value = azurerm_container_registry.acr.admin_password
  sensitive = true
}

output "url" {
  value = azurerm_container_registry.acr.login_server
}