resource "azurerm_mssql_database" "database" {
  name = "${var.environment}-db"
  server_id = azurerm_mssql_server.sql-server
  collation = "SQL_Latin1_General_CP1_CI_AS"
  license_type = var.license_type
  max_size_gb = var.max_size_gb
  sku_name = var.sql_sku_name
  zone_redundant = var.zone_redundant

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_mssql_database" "repo-database" {
  name = "${var.environment}-repo"
  server_id = azurerm_mssql_server.sql-server
  collation = "SQL_Latin1_General_CP1_CI_AS"
  license_type = var.license_type
  max_size_gb = var.max_size_gb
  sku_name = var.sql_sku_name
  zone_redundant = var.zone_redundant

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    environment = var.environment
  }
}

#This SQL script below will create the necessary SQL user for the backend API conapp to leverage
#NOTE: EXTERNAL PROVIDER is a built-in with Azure SQL Server
#CREATE USER [<backend-app-msi-name>] FROM EXTERNAL PROVIDER;
#ALTER ROLE db_datareader ADD MEMBER [<backend-app-msi-name>];
#ALTER ROLE db_datawriter ADD MEMBER [<backend-app-msi-name>];
