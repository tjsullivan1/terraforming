resource "azurerm_storage_account" "funcstore" {
  name                     = "stor${var.name}${var.env}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "asp" {
  name                = "azapp-${var.name}-${var.env}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "FunctionApp"

  sku {
    tier = var.function_tier
    size = var.function_size
  }
}

resource "azurerm_function_app" "function" {
  name                      = "azfun-${var.name}-${var.env}"
  location                  = azurerm_resource_group.rg.location
  resource_group_name       = azurerm_resource_group.rg.name
  app_service_plan_id       = azurerm_app_service_plan.asp.id
  storage_connection_string = azurerm_storage_account.funcstore.primary_connection_string
}