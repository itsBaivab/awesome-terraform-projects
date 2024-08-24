resource "azurerm_storage_account" "storage_account" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = var.storage_account_name
  account_tier        = "Standard"
  account_replication_type = "RAGRS"
  account_kind        = "StorageV2"

  static_website {
    index_document = "index.html"
    error_404_document = "404errorpage.html"
  }
  tags = {
    environment = "prod-static-website-hosting"
  }
}
