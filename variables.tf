variable application_code {
    description = "Código de aplicación a desplegar."
    type = string
}

variable resource_correlative {
    description = "Especifica el número correlativo asignado al recurso."
    type = string
    default = "01"
}

variable base_correlative {
    description = "Especifica el numero correlativo asignado a la infraestructura base."
    type = string
    default = "01"
}

variable environment {
    description = "Especifica el ambiente en el que se desplegará la aplicación."
    type = string    
}

variable location {
    description = "Código de la región a desplegar."
    type = list(string)
}

variable aspl_sku_tier {
  description = "Especifica el nivel del Service Plan."
  type        = string    
}

variable aspl_sku_size {
  description = "Especifica el tamaño del Service Plan."
  type        = string    
}

variable aspl_kind {
  description = "Especifica el sistema  operativo al cual el Service Plan esta dirigido."
  type        = string
  validation {
    condition     = contains(["linux", "windows"], var.aspl_kind)
    error_message = "Only linux/windows values are allowed, see README."
  }
}

locals {
  map_locations_code = { 
    eu2 = "eastus2"
    cus = "centralus"
  }

  aspl_code = "aspl"
  rsgr_code = "rsgr"
  
  map_aspl = {
    for region in var.location :
      local.map_locations_code[lower(region)] => {
        aspl_name = lower(format("%s%s%s%s%s", local.aspl_code, region, var.application_code, var.environment, var.resource_correlative)),
        aspl_rsgr = upper(format("%s%s%s%s%s", local.rsgr_code, region, var.application_code, var.environment, var.base_correlative))
    }
  }

  aspl_kind   = var.aspl_kind
  aspl_reserved = var.aspl_kind == "linux" ? true : false
  aspl_tier   = title(var.aspl_sku_tier)
  aspl_size   = upper(var.aspl_sku_size)
  
}