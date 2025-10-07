client_id       = ""
client_secret   = ""
subscription_id = ""
tenant_id       = ""
# Service Principal

# Resource group & location
resource_group_name = "rg-demo"
location            = "centralindia"

# Network
vnet_name      = "vnet-demo"
address_space  = ["10.0.0.0/16"]
subnet_name    = "subnet-demo"
subnet_prefix  = ["10.0.1.0/24"]
nic_name       = "nic-demo"
public_ip_name = "pip-demo"

# Security
nsg_name = "nsg-demo"
security_rules = [
  {
    name                       = "Allow-SSH"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "Allow-HTTP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "Allow-HTTPS"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]

# Compute
vm_name        = "vm-demo"
vm_size        = "Standard_B1s"
admin_username = "azureuser"
admin_password = "P@ssword123!"
image_reference = {
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "18.04-LTS"
  version   = "latest"
}
