variable "nsg_name" {
  description = "The name of the Network Security Group."
  type        = string
}

variable "security_rules" {
  description = "A list of security rules to be applied to the NSG."
  type        = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}