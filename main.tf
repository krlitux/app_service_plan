resource "azurerm_app_service_plan" "aspl" {
  for_each            = local.map_aspl
  name                = each.value.aspl_name
  resource_group_name = each.value.aspl_rsgr
  location            = each.key
  kind                = local.aspl_kind
  reserved            = local.aspl_reserved
  sku {
    tier = local.aspl_tier
    size = local.aspl_size
  }
}
