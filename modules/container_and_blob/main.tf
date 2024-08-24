locals {
  files = {
    "index.html"         = "tic-tac-toe-js\\index.html"
    "404errorpage.html"  = "tic-tac-toe-js\\404errorpage.html"
    "tic-tac-toe.js"          = "tic-tac-toe-js\\tic-tac-toe.js"
    "tic-tac-toe.css"         = "tic-tac-toe-js\\tic-tac-toe.css"
  }
}

resource "azurerm_storage_blob" "website_files" {
  for_each              = local.files
  name                  = each.key
  storage_account_name  = var.storage_account_name
  storage_container_name = "$web"
  type                  = "Block"
  source                = each.value
  content_type          = (
                            each.key == "index.html" || each.key == "404errorpage.html" ? "text/html" :
                            each.key == "tic-tac-toe.css" ? "text/css" :
                            each.key == "tic-tac-toe.js" ? "text/javascript" : "application/octet-stream"
                          )
}