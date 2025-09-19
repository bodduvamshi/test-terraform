variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "address_space" {
  description = "The address space for the virtual network."
  type        = list(string)
}

variable "subnet_names" {
  description = "A list of subnet names."
  type        = list(string)
}

variable "subnet_prefixes" {
  description = "A list of subnet address prefixes."
  type        = list(string)
}

variable "nsg_name" {
  description = "The name of the network security group."
  type        = string
}

variable "location" {
  description = "The Azure location where the resources will be created."
  type        = string
}