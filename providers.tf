provider "azurerm" {
  features {}

  client_id       = var.client_id         // Service Principal App ID
  client_secret   = var.client_secret     // Service Principal Password
  subscription_id = var.subscription_id   // Azure Subscription ID
  tenant_id       = var.tenant_id         // Azure Tenant ID
}