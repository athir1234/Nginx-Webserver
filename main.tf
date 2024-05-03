resource "random_string" "name" {
  upper = false
  length = 5
  special = false
}

resource "azurerm_resource_group" "my_resource_group" {
  name     = var.rgname
  location = var.location
}

# resource "azurerm_virtual_network" "vnet" {
#   name                = var.vnetname
#   location            = var.location
#   resource_group_name = azurerm_resource_group.my_resource_group.name
#   address_space       = var.addspace 
#   dns_servers         = var.dnsservers
# }

# locals {
#   value = length(var.address_prefix)
#   zones = 2
# }

# resource "azurerm_subnet" "linuxsubnet" {
#   depends_on = [ azurerm_virtual_network.vnet ]
#   count = local.value
#   name                 = "subnet-nginx-${count.index+1}"
#   resource_group_name  = azurerm_resource_group.my_resource_group.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   # address_prefixes     = "10.0.${count.index}.0/24"
#   address_prefixes     = [var.address_prefix[count.index]]
# }

# # resource "azurerm_subnet" "bastionsubnet" {
# #   name                 = "AzureBastionSubnet"
# #   resource_group_name  = azurerm_resource_group.my_resource_group.name
# #   virtual_network_name = azurerm_virtual_network.vnet.name
# #   # address_prefixes     = "10.0.${count.index}.0/24"
# #   address_prefixes     = var.bastionhost
# # }

# resource "azurerm_public_ip" "pip" {
  
#   name                = "Pipnginx"
#   resource_group_name = azurerm_resource_group.my_resource_group.name
#   location            = var.location
#   allocation_method   = "Static"
#   domain_name_label = lower("PipNginx")
#   zones = [1]
#   sku = "Standard"
# }

# # resource "azurerm_bastion_host" "bastionhost" {
# #   name = "bastionhost"
# #   location = var.location
# #   resource_group_name = azurerm_resource_group.my_resource_group.name
# #   ip_configuration {
# #     name = "ipconfig"
# #     subnet_id = azurerm_subnet.bastionsubnet.id
# #     public_ip_address_id = azurerm_public_ip.pip.id
# #   }
# # }


# resource "azurerm_network_interface" "net-int" {
#   depends_on = [ azurerm_virtual_network.vnet ]
#   count = local.value
#   name                = "NginxNic--${count.index+1}"
#   location            = var.location
#   resource_group_name = azurerm_resource_group.my_resource_group.name

#   ip_configuration {
#     name                          = "NginxPrivateIp${count.index}"
#     subnet_id                     = azurerm_subnet.linuxsubnet[count.index].id
#     private_ip_address_allocation = "Dynamic"    
#     public_ip_address_id = "${azurerm_subnet.linuxsubnet[count.index].name}" == "subnet-nginx-1" ? azurerm_public_ip.pip.id : null
#   }
# }

# resource "azurerm_linux_virtual_machine" "Nginx" {
#   count = local.value
#   name                = "NginxServer-${count.index+1}"
#   resource_group_name = azurerm_resource_group.my_resource_group.name
#   location            = var.location
#   zone                = "${count.index}" <= 2 ? "${count.index+1}" : null
#   custom_data = base64encode(file("init.sh"))
#   size                = var.machine_size
#   admin_username      = var.username
#   admin_password = var.password
#   disable_password_authentication = false
#   network_interface_ids = [
#     azurerm_network_interface.net-int[count.index].id
#   ]
  
#   admin_ssh_key {
#     username = var.username
#     public_key = file("~/.ssh/id_rsa.pub")
#   }
#   os_disk {
#     caching              = var.caching
#     storage_account_type = var.accnttype
#   }

#   source_image_reference {
#     publisher = var.ospublisher
#     offer     = var.offer
#     sku       = var.sku
#     version   = var.release
#   }
# }

# resource "azurerm_network_security_group" "nsgnginx" {
  
#   name                = "NSG-${random_string.name.result}"
#   location            = var.location
#   resource_group_name = azurerm_resource_group.my_resource_group.name

#   dynamic "security_rule" {
#     for_each = var.security_rule
#     content {
#       name                       = security_rule.value.name
#       priority                   = security_rule.value.priority
#       direction                  = security_rule.value.direction
#       access                     = security_rule.value.access
#       protocol                   = security_rule.value.protocol
#       source_port_range          = security_rule.value.source_port_range
#       destination_port_range     = security_rule.value.destination_port_range
#       source_address_prefix      = security_rule.value.source_address_prefix
#       destination_address_prefix = security_rule.value.destination_address_prefix
#     }
#   }
# }

# resource "azurerm_subnet_network_security_group_association" "nsgassociation" {
#   count = local.value
#   subnet_id = azurerm_subnet.linuxsubnet[count.index].id
#   network_security_group_id = azurerm_network_security_group.nsgnginx.id
# }

# # resource "azurerm_storage_account" "stgaccnt" {
# #   name = "mynginxstgaccnt${random_string.name.result}"
# #   resource_group_name = azurerm_resource_group.my_resource_group.name
# #   location = var.location
# #   account_tier = "Standard"
# #   account_replication_type = "LRS"
# #   access_tier = "Cool"
# # }

# # resource "azurerm_storage_container" "stgcontainer" {
# #   name = "nginxcontainer"
# #   storage_account_name = azurerm_storage_account.stgaccnt.name
# #   container_access_type = "container"
    
# # }

# # resource "azurerm_storage_blob" "stgblob" {
# #   name = "nginx-script.sh"
# #   storage_account_name = azurerm_storage_account.stgaccnt.name
# #   storage_container_name = azurerm_storage_container.stgcontainer.name
# #   type = "Block"
# #   source = "C:/Reciprocal/Technical/Azure/Terraform/TFFiles/Nginx-WebServer-Availability zone/init.sh" 
# # }

# # # resource "azurerm_virtual_machine_extension" "extension" {
# # #   count = local.value
# # #   name = "hostname"
# # #   publisher = "Microsoft.Azure.Extensions"
# # #   virtual_machine_id = azurerm_linux_virtual_machine.Nginx[count.index].id
# # #   type = "Customscript"
# # #   type_handler_version = "2.0"

# # #   settings = <<SETTINGS
# # #   {
# # #     "commandToExecute": "sh nginx-script.sh",
# # #     "fileUris" : ["https://mynginxstgaccnt5iujn.blob.core.windows.net/nginxcontainer/nginx-script.sh"]
# # #     }
# # #     SETTINGS
# # # }