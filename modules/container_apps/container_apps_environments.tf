#We can leverage a single container app environment to securely host all three of our
#container app resources, and only expose the two front end containers
resource "azurerm_container_app_environment" "conapp-environment" {
  name = "${var.environment}-conapp-environment"
  location = var.location
  resource_group_name = "${var.environment}-rg"
  log_analytics_workspace_id = var.log_analytics_workspace_id
  infrastructure_subnet_id = var.infrastructure_subnet_id
#Azure Monitor is where we are analyzing all our container metrics from the LA workspace
  tags = {
    environment = var.environment
  }
}

#The API is never exposed publicly since "external_enabled" is only 'true' on our two frontend conapps.
#The frontends are public without exposing our subnet and all east–west traffic stays inside the environment.
#Azure handles TLS internally, so we don’t manage certs for HTTPS between conapp resources.
#The private_subnet only hosts the environment infrastructure, not our public endpoints.
