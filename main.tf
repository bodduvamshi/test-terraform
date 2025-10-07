# Resource group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

# Network module
module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  subnet_name         = var.subnet_name
  subnet_prefix       = var.subnet_prefix
  nic_name            = var.nic_name
  public_ip_name      = var.public_ip_name
}

# Security module
module "security" {
  source              = "./modules/security"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  nsg_name            = var.nsg_name
  security_rules      = var.security_rules
}

# Compute module
module "compute" {
  source = "./modules/compute"

  vm_name               = var.vm_name
  vm_size               = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  network_interface_ids = [module.network.network_interface_id]
  image_reference       = var.image_reference
}
