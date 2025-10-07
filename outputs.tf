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
