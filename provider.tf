terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.101.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~>3.0"
    }
  }
    backend "azurerm" {
    resource_group_name  = "NetworkWatcherRG"
    storage_account_name = "tfstatefile2024041423"
    container_name       = "tfstatecontainer"
    key                  = "terraform.tfstate"
  }
}
provider "azurerm" {
  features {
    
  }
}