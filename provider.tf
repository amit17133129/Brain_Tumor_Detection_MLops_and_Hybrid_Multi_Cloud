provider "aws" {
  profile = "terraformuser1"
  region  = "ap-south-1"
}

provider "google" {
  project     = "multicloud-315014"
  region      = "asia-south1"
  credentials = "multicloud-315014-33130779fd5d.json"
}

# Configure the Microsoft Azure Provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}
provider "azurerm" {
  subscription_id = "xxxxxxxxxxxxxxxxxx"
  client_id       = "xxxxxxxxxxxxxxxxxx"
  client_secret   = "xxxxxxxxxxxxxxxxxx"
  tenant_id       = "xxxxxxxxxxxxxxxxxx"
  features {}
}
