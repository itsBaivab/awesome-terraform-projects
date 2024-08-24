module "resource_group" {
  source              = "./modules/resource_group"
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Generate random value for the storage account name
resource "random_string" "storage_account_name" {
  length  = 8
  lower   = true
  numeric = false
  special = false
  upper   = false
}

module "storage_account" {
  source               = "./modules/storage_account"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_name = random_string.storage_account_name.result
  depends_on           = [module.resource_group]
}


module "container_and_blob" {
  source               = "./modules/container_and_blob"
  storage_account_name = module.storage_account.storage_account_name
  depends_on = [module.storage_account]
}

# Define the Azure Front Door module
module "front_door" {
  source                       = "./modules/front_door"
  location                     = var.location
  front_door_name              = var.front_door_name
  resource_group_name          = var.resource_group_name
  static_website_host_endpoint = module.storage_account.storage_account_primary_web_host
  depends_on                   = [module.container_and_blob]
}