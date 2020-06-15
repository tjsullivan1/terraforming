# Configure the Azure provider
provider "azurerm" {
  version = "=2.13.0"
  features {}
}

module "webserver" {
  source = "github.com/tjsullivan1/terraforming/modules/services/az-function"

  env                 = "d"
  name                = "linkpar"
  resource_group_name = "rg-linker-parser-d"
  os                  = "linux"
}
