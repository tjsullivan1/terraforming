data "azurerm_key_vault" "existing" {
  name                = "kv-tjs-01"
  resource_group_name = "rg-development-resources-01"
}

data "azurerm_key_vault_secret" "client_secret" {
  name = "terraform-client-secret"
  key_vault_id = data.azurerm_key_vault.existing.id
}

data "azurerm_key_vault_secret" "oauth_token_id" {
  name = "terraform-oauth-token-id"
  key_vault_id = data.azurerm_key_vault.existing.id
}

resource "tfe_workspace" "myws" {
  # (resource arguments)
  name         = var.workspace_name
  organization = "tjssullivanent"

  working_directory = var.component_path
  trigger_prefixes = [var.component_path]

  vcs_repo {
    identifier = var.repo_path
    oauth_token_id = data.azurerm_key_vault_secret.oauth_token_id.value
  }
}

resource "tfe_variable" "client_id" {
  key          = "ARM_CLIENT_ID"
  value        = "2a67101a-85bd-46e4-ab82-bf1eddbe011d"
  category     = "env"
  workspace_id = tfe_workspace.myws.id
  description  = "The Application ID for the service principal called 'terraform-cloud-user'"
}

resource "tfe_variable" "tenant_id" {
  key          = "ARM_TENANT_ID"
  value        = "012c6d21-cad3-4e61-98dd-2bc660a112b8"
  category     = "env"
  workspace_id = tfe_workspace.myws.id
  description  = "tjssullivanent.onmicrosoft.com Azure AD GUID"
}

resource "tfe_variable" "sub_id" {
  key          = "ARM_SUBSCRIPTION_ID"
  value        = "f33f4d2a-99ac-47ab-8142-a5f6f768020f"
  category     = "env"
  workspace_id = tfe_workspace.myws.id
  description  = "The subscription 'Visual Studio Enterprise'"
}

resource "tfe_variable" "client_secret" {
  key          = "ARM_CLIENT_SECRET"
  value        = data.azurerm_key_vault_secret.client_secret.value
  category     = "env"
  workspace_id = tfe_workspace.myws.id
  sensitive    = "true"
  description  = "Saved in lastpass"
}