terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.45.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {

  }
}

# terraform import azurerm_resource_group.first_resource_group /subscriptions/a37ca5e2-93d4-4c6d-997a-a6358f84f0f7/resourceGroups/firstresourcegroup

resource "azurerm_resource_group" "resource_group" {
  name     = "resource-group"
  location = "eastus"
}

resource "azurerm_resource_group" "resource_groups" {
  name     = "${var.resource_groups_name}-${count.index}"
  location = "eastus"
  count    = var.num_resource_groups
}

# terraform import azurerm_virtual_network.first_virtual_machine_vnet /subscriptions/a37ca5e2-93d4-4c6d-997a-a6358f84f0f7/resourceGroups/firstresourcegroup/providers/Microsoft.Network/virtualNetworks/firstvirtualmachine-vnet

resource "azurerm_virtual_network" "first_virtual_machine_vnet" {
  name                = each.value
  location            = "eastus"
  resource_group_name = "resource-group"
  address_space       = ["10.0.0.0/24"]
  for_each            = toset(var.vnet_names)
}

variable "resource_groups_name" {
  default = "resource-group"
}

variable "num_resource_groups" {
  default = 2
}

variable "vnet_names" {
  default = ["vnet-1", "vnet-2"]
}
