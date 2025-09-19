provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.main.name
  location           = azurerm_resource_group.main.location
  vnet_name          = var.vnet_name
  address_space      = var.address_space
  subnet_name        = var.subnet_name
  subnet_prefix      = var.subnet_prefix
}

module "compute" {
  source              = "./modules/compute"
  resource_group_name = azurerm_resource_group.main.name
  location           = azurerm_resource_group.main.location
  vm_name            = var.vm_name
  vm_size            = var.vm_size
  admin_username     = var.admin_username
  admin_password     = var.admin_password
  network_interface_id = module.network.network_interface_id
}

module "security" {
  source              = "./modules/security"
  resource_group_name = azurerm_resource_group.main.name
  location           = azurerm_resource_group.main.location
  nsg_name           = var.nsg_name
  security_rules     = var.security_rules
}

output "resource_group_id" {
  value = azurerm_resource_group.main.id
}

output "vnet_id" {
  value = module.network.vnet_id
}

output "vm_id" {
  value = module.compute.vm_id
}

output "nsg_id" {
  value = module.security.nsg_id
}