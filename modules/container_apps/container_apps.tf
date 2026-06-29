resource "azurerm_container_app" "conapp" {
    for_each = local.container_apps
    
    name = each.value.name
    container_app_environment_id = azurerm_container_app_environment.conapp-environment.id
    resource_group_name = "${var.environment}-rg"
    revision_mode = var.revision_mode
#For top-level arguments that are not nested within dynamic blocks, we must write out the full chain
#as detailed below in our nested "container" block:
    template {
      container {
        name = each.value.template.container.name
        image = each.value.template.container.image
        cpu = var.container_cpu
        memory = var.container_memory
      
        dynamic "env" {
          for_each = each.value.template.container.env
          content {
            name = env.value.name
            value = env.value.value
          }
        }
      }
#Dynamic blocks allow us to accomodate for variances between related resources where one may have a nested
#block such as "ingress" where another may only have "egress", they accomodate for empty blocks
        dynamic "custom_scale_rule" {
          for_each = each.value.template.custom_scale_rule == null ? [] : [each.value.template.custom_scale_rule]
          content {
            name             = custom_scale_rule.value.name
            custom_rule_type = "cpu"
            metadata         = custom_scale_rule.value.metadata
          }
        }
      }
#The for_each lines that leverage "?", its actually just a ternary operator which is a compact if-else expression
#so it reads as "if ingress is null, use an empty list, otherwise, use a list containing the object"
#Terraform treats the squared brackets arrangement as [OPTION A (generate ZERO blocks)] OR [OPTION B (use ingress block found in locals)]
    dynamic "ingress" {
      for_each = each.value.ingress == null ? [] : [each.value.ingress]
      content {
        external_enabled = ingress.value.external_enabled
        target_port      = ingress.value.target_port
        transport        = "auto"
        fqdn             = ingress.value.fqdn
      
      dynamic "traffic_weight" {
        for_each = ingress.value.traffic_weight
        content {
          latest_revision = true
          percentage      = var.traffic_weight
        }
      }
    }
  }
}
