output "nsg_id" {
  value = azurerm_network_security_group.example.id
}

output "security_rule_ids" {
  value = azurerm_network_security_rule.example.*.id
}