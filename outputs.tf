output "aspl_name" {
  description = "Mapa con los nombres de los App Service Plan aprovisionados"
  value = { for region in keys(azurerm_app_service_plan.aspl) : region => azurerm_app_service_plan.aspl[region].name }
}
output "aspl_tier" {
  description = "Mapa con los nombres de los App Service Plan aprovisionados"
  value = local.aspl_tier
}
output "aspl_id" {
  description = "Mapa con los nombres de los App Service Plan aprovisionados"
  value = { for region in keys(azurerm_app_service_plan.aspl) : region => azurerm_app_service_plan.aspl[region].id }
}