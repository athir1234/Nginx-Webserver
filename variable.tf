variable "rgname" {
  type = string
  description = "(optional) describe your variable"
}

variable "vnetname" {
  type = string
  description = "(optional) describe your variable"
}

variable "location" {
  type = string
  description = "(optional) describe your variable"
}

variable "dnsservers" {
  type = list(string)
  description = "(optional) describe your variable"
}

variable "addspace" {
  type = list(string)
  description = "(optional) describe your variable"
}

variable "machine_size" {
  type = string
  description = "(optional) describe your variable"
}

# variable "bastionhost" {
#   type = list(string)
#   description = "(optional) describe your variable"
# }
# variable "subnetname" {
#     type = string
#     description = "(optional) describe your variable"
#  }

# variable "vnet" {
#     type = string
#     description = "(optional) describe your variable"
# }

variable "address_prefix" {
  type = list(string)
}

variable "username" {
  type = string
  description = "(optional) describe your variable"
}

variable "password" {
  type = string
  description = "(optional) describe your variable"
}

variable "caching" {
  type = string
  description = "(optional) describe your variable"
}

variable "accnttype" {
  type = string
  description = "(optional) describe your variable"
}

variable "ospublisher" {
  type = string
  description = "(optional) describe your variable"
}

variable "offer" {
  type = string
  description = "(optional) describe your variable"
}

variable "sku" {
  type = string
  description = "(optional) describe your variable"
}

variable "release" {
  type = string
  description = "(optional) describe your variable"
}

variable "security_rule" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = number
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = [{
    name                       = "ssh"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 22
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    },
    {
    name                       = "Http"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 80
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    }
    ]
}