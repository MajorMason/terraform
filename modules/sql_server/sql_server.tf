resource "azurerm_mssql_server" "sql-server" {
  name = "${var.environment}-sql"
  resource_group_name = "${var.environment}-rg"
  location = var.location
  version = var.sql_version
  administrator_login = var.sql_login
  administrator_login_password = var.sql_pass
  minimum_tls_version = "1.2"
#There is no argument needed to link our MSSQL Server to its private endpoint, because the PE is the consumer
#while the MSSQL Server is the provider in a sense
  azuread_administrator {
    login_username = var.entraid_login
    object_id = var.object_id
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_management_lock" "sql-lock" {
  name = "${var.environment}-sql-lock"
  scope = azurerm_mssql_server.sql-server.id
  lock_level = var.sql_lock
}
