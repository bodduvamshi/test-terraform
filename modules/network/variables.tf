variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location where resources will be created."
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "address_space" {
  description = "The address space of the virtual network."
  type        = list(string)
}

variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}

variable "subnet_prefix" {
  description = "The address prefix of the subnet."
  type        = list(string)
}

variable "nic_name" {
  description = "The name of the network interface."
  type        = string
}

variable "public_ip_name" {
  description = "The name of the public IP."
  type        = string
}
