terraform {
  required_version = "~>1.1.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.101.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
  # backend "azurerm" {
  #   resource_group_name  = "tfstatefilerg"
  #   storage_account_name = "tfstatefile2024041423"
  #   container_name       = "tfstatecontainer"
  #   key                  = "terraform.tfstate" #seperate statefile for each workspace env will be created automatically in remote/local
  # }
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "terraform_practice_2024"

    workspaces {
      name = "Nginx-Webserver-Dev"
    }
  }
}
provider "azurerm" {
  features { }
  use_oidc = true
}