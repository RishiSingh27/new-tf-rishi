terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rishi-tf-rg"
    storage_account_name = "rishistorage123"
    container_name       = "rishi-terraform-state"
    key                  = "jenkins-demo.tfstate"
  }
}

provider "azurerm" {
  features {}

}

resource "azurerm_resource_group" "rg" {
  name     = "rishi-JenkinsTerraformRG-new-1"
  location = "Central US"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "rishi-JenkinsVNet-new"
  address_space       = ["10.30.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
