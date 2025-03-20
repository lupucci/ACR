provider "azurerm" {
  features {}
  subscription_id = ""
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-aci"
  location = "brazilsouth"
}

resource "azurerm_container_group" "aci" {
  name                = "acicontainer"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  dns_name_label      = "acicontainer"
  ip_address_type     = "Public"

  image_registry_credential {
    server   = "acrregistryluiz.azurecr.io"
    username = azurerm_container_registry.acr.admin_username
    password = azurerm_container_registry.acr.admin_password
  }

  container {
    name   = "acicontainer"
    image  = "luizpucci/aci:latest"
    cpu    = "0.5"
    memory = "1.5"
    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}