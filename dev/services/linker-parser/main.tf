# Configure the Azure provider
provider "azurerm" {
    version = "=2.13.0"
    features {}
}

# Create a new resource group
resource "azurerm_resource_group" "rg" {
    name     = "rg-linker-parser"
    location = "eastus"
}

module "webserver" {
  source = "github.com/tjsullivan1/terraforming/modules/services/az-function"

  env = "d"
  name = "linkpar"
  resource_group_name = azurerm_resource_group.rg.name

}
