terraform {
  required_providers {
    tfe = "~> 0.15.1"
  }
}

provider "azurerm" {
  version = "=2.13.0"
  features {}
}

module "dev-webserver" {
    source = "github.com/tjsullivan1/terraforming/modules/global/tf-cloud"

    workspace_name = "dev-webserver"
}