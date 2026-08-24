resource "azurerm_mssql_database" "database" {
  name = "${var.environment}-db"
  server_id = azurerm_mssql_server.sql-server.id
  collation = "SQL_Latin1_General_CP1_CI_AS"
  license_type = var.license_type
  max_size_gb = var.max_size_gb
  sku_name = var.sql_sku_name
  zone_redundant = var.zone_redundant
  depends_on = [azurerm_mssql_server.sql-server]

  short_term_retention_policy {
    retention_days           = var.retention_days  # Maximum window for rapid recovery
    backup_interval_in_hours = var.primary_backup_interval
  }

  #Long-Term Retention (Compliance)
  long_term_retention_policy {
    weekly_retention  = var.weekly_retention   # Keep weekly backups for 4 weeks
    monthly_retention = var.monthly_retention  # Keep monthly backups for 12 months
    yearly_retention  = var.primary_yearly_retention   # Keep yearly backups for 5 years
    week_of_year      = var.week_of_year       # Required when yearly_retention is set
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_mssql_database" "repo-database" {
  name = "${var.environment}-repo"
  server_id = azurerm_mssql_server.sql-server.id
  collation = "SQL_Latin1_General_CP1_CI_AS"
  license_type = var.license_type
  max_size_gb = var.max_size_gb
  sku_name = var.sql_sku_name
  zone_redundant = var.zone_redundant
  depends_on = [azurerm_mssql_server.sql-server]

  short_term_retention_policy {
    retention_days           = var.retention_days  # Maximum window for rapid recovery
    backup_interval_in_hours = var.repo_backup_interval
  }

  #Long-Term Retention (Compliance)
  long_term_retention_policy {
    weekly_retention  = var.weekly_retention   # Keep weekly backups for 4 weeks
    monthly_retention = var.monthly_retention  # Keep monthly backups for 12 months
    yearly_retention  = var.repo_yearly_retention   # Keep yearly backups for 5 years
    week_of_year      = var.week_of_year       # Required when yearly_retention is set
  }

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
