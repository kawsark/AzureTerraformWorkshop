# tEST
provider "azurerm" { 
  }

resource "azurerm_resource_group" "main" {
  name     = "${var.resourcegroup}"
  location = "${var.location}"
}

resource "azurerm_storage_account" "main" {
  name                     = "azcntinststor${var.username}"
  resource_group_name      = "${azurerm_resource_group.main.name}"
  location                 = "${azurerm_resource_group.main.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "main" {
  name                 = "aci-test-share"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  storage_account_name = "${azurerm_storage_account.main.name}"
  quota                = 1
}

# Linux Container
resource "azurerm_container_group" "main" {
  name                = "${var.username}-aci-helloworld"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  ip_address_type     = "public"
  dns_name_label      = "aci-${var.username}"
  os_type             = "linux"

  container {
    name   = "helloworld"
    image  = "microsoft/aci-helloworld"
    cpu    = "${var.cpu}"
    memory = "${var.memory}"
    port   = "80"

    environment_variables {
      "NODE_ENV" = "testing"
    }

    volume {
      name       = "logs"
      mount_path = "/aci/logs"
      read_only  = false
      share_name = "${azurerm_storage_share.main.name}"

      storage_account_name = "${azurerm_storage_account.main.name}"
      storage_account_key  = "${azurerm_storage_account.main.primary_access_key}"
    }
  }

  container {
    name   = "sidecar"
    image  = "microsoft/aci-tutorial-sidecar"
    cpu    = "${var.cpu}"
    memory = "${var.memory}"
  }

  tags {
    environment = "${var.environment}"
    owner = "${var.owner}"
  }
}

# Windows Container
resource "azurerm_container_group" "windows" {
  name                = "${var.username}-aci-iis"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  ip_address_type     = "public"
  dns_name_label      = "aci-iis-${var.username}"
  os_type             = "windows"

  container {
    name   = "dotnetsample"
    image  = "microsoft/iis"
    cpu    = "${var.cpu}"
    memory = "${var.memory}"
    port   = "80"
  }

  tags {
    environment = "${var.environment}"
    owner = "${var.owner}"
  }
}

resource "azurerm_container_group" "windows2" {
  name                = "${var.username}-aci-iis"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  ip_address_type     = "public"
  dns_name_label      = "aci-iis-${var.username}"
  os_type             = "windows"

  container {
    name   = "dotnetsample"
    image  = "microsoft/iis"
    cpu    = "${var.cpu}"
    memory = "${var.memory}"
    port   = "80"
  }

  tags {
    environment = "${var.environment}"
    owner = "${var.owner}"
  }
}
