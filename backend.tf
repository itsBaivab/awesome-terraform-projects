terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "stterraformstatefordev"
    container_name       = "dev-tfstate"
    key                  = "dev.terraform.tfstate"
  }

}