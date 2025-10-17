terraform {
  required_version = ">= 1.6"

  cloud {
    organization = "BS_INC"
    
    workspaces {
      name = "env-test"  # Also: env-staging, env-prod
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