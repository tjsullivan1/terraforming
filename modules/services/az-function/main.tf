data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_storage_account" "funcstore" {
  name                     = "stor${var.name}${var.env}"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "asp" {
  name                = "azapp-${var.name}-${var.env}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  kind                = "FunctionApp"
  reserved = (var.os == "linux"
    ? true
  : false)

  sku {
    tier = var.function_tier
    size = var.function_size
  }
}

resource "azurerm_application_insights" "appin" {
  name                = "appin-${var.name}-${var.env}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  application_type    = "web"
}

resource "azurerm_function_app" "function_lin" {
  count = (var.os == "linux"
    ? 1
  : 0)

  name                       = "azfun-${var.name}-${var.env}"
  location                   = data.azurerm_resource_group.rg.location
  resource_group_name        = data.azurerm_resource_group.rg.name
  app_service_plan_id        = azurerm_app_service_plan.asp.id
  storage_account_access_key = azurerm_storage_account.funcstore.primary_access_key
  storage_account_name       = azurerm_storage_account.funcstore.name
  os_type                    = var.os

  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.appin.instrumentation_key
  }
}

resource "azurerm_function_app" "function_win" {
  count = (var.os == "linux"
    ? 0
  : 1)

  name                       = "azfun-${var.name}-${var.env}"
  location                   = data.azurerm_resource_group.rg.location
  resource_group_name        = data.azurerm_resource_group.rg.name
  app_service_plan_id        = azurerm_app_service_plan.asp.id
  storage_account_access_key = azurerm_storage_account.funcstore.primary_access_key
  storage_account_name       = azurerm_storage_account.funcstore.name

  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.appin.instrumentation_key
  }
}