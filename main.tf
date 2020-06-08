# Configure the Azure provider
provider "azurerm" {
    version = "=2.13.0"
    features {}
}

# Create a new resource group
resource "azurerm_resource_group" "rg" {
    name     = "myTFResourceGroup"
    location = "eastus"
}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
    name                = "myTFVnet"
    address_space       = ["10.0.0.0/16"]
    location            = "westus2"
    resource_group_name = azurerm_resource_group.rg.name
}