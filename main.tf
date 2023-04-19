locals {
  resource_group_name  = "rjexample-rg"
  storage_account_name = "rjexamplestorageaccount"
  cdn_profile_name     = "rjexample-cdn-profile"
  cdn_endpoint_name    = "rjexample-cdn-endpoint"
}


resource "azurerm_dns_cname_record" "example" {
  name                = "rjcdn" # The subdomain for the CNAME record, e.g., cdn.rjcdn.azure.vsystems.online
  zone_name           = "azure.vsystems.online"
  resource_group_name = "DNS"
  ttl                 = 300
  record              = "rjexample-cdn-endpoint.azureedge.net"
}


resource "azurerm_resource_group" "example" {
  name     = local.resource_group_name
  location = "Central US"
}

resource "azurerm_storage_account" "example" {
  name                     = local.storage_account_name
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document = "index.html"
    error_404_document = "404.html"
  }
}

resource "azurerm_storage_blob" "index_html" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "index.html" # Path to your local index.html file
  content_type           = "text/html"
}

resource "azurerm_storage_blob" "css" {
  name                   = "style.css"
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "style.css" # Path to your local index.html file
  content_type           = "text/css"
}

resource "azurerm_storage_blob" "image" {
  name                   = "azure.jpg"
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "azure.jpg" # Path to your local index.html file
  content_type           = "text/jpg"
}

resource "azurerm_cdn_profile" "example" {
  name                = local.cdn_profile_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Standard_Microsoft"
}

resource "azurerm_cdn_endpoint" "example" {
  name                = local.cdn_endpoint_name
  profile_name        = azurerm_cdn_profile.example.name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  origin_host_header  = azurerm_storage_account.example.primary_web_host

  origin {
    name      = local.storage_account_name
    host_name = azurerm_storage_account.example.primary_web_host
  }

  depends_on = [azurerm_storage_account.example]
}

resource "azurerm_cdn_endpoint_custom_domain" "example" {
  name                = "example-custom-domain"
  host_name           = "rjcdn.azure.vsystems.online"
  cdn_endpoint_id = azurerm_cdn_endpoint.example.id
  cdn_managed_https {
      certificate_type = "Dedicated"
      protocol_type = "ServerNameIndication"
  }
}


