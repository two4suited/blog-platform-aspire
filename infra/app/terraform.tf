terraform {
  required_version = ">= 1.6"

  cloud {
    organization = "BS_INC"
    
    workspaces {
      name = "app-test"  # For tutorial; use app-myapp-dev, app-myapp-staging, app-myapp-prod for multiple environments
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.40"
    }
  }
}

provider "azurerm" {
  features {}
}