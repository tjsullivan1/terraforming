# Configure the Azure provider
provider "azurerm" {
    version = "=2.13.0"
    features {}
}

# Create a new resource group
resource "azurerm_resource_group" "rg" {
    name     = "rg-terraform-learning"
    location = "eastus"
}

module "webserver" {
  source = "github.com/tjsullivan1/terraforming/modules/services/webserver"

  ssh_key = var.ssh_key
  server_port = 8080
  instance_sku = "Standard_F2"
  name = "vm1"

  custom_tags = {
   Owner = "tim Sullivan"
   DeployedBy = "Terraform" 
  }
}