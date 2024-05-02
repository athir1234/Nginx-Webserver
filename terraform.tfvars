rgname = "nginx-webserver-az"

vnetname = "nginx-vnet"

location = "Eastus"

addspace = [ "10.0.0.0/16" ]

# address_prefix = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
address_prefix = ["10.0.1.0/24","10.0.2.0/24"]
# address_prefix = ["10.0.1.0/24"]

dnsservers = [ "8.8.8.8" ]

# bastionhost = [ "10.0.4.0/28" ]

username         = "useradmin"
password         = "Password@123"
caching          = "ReadWrite"
accnttype        = "Standard_LRS"
ospublisher      = "Canonical"
offer            = "0001-com-ubuntu-server-jammy"
sku              = "22_04-lts"
release          = "latest"
machine_size = "Standard_B1s"