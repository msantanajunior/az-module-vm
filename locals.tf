locals {
  sizes = {
      "Standard_D8s_v4" = "StandardSSD_LRS"
      "Standard_E48ds_v4" = "Premium_LRS"
      "Standard_D32s_v4" = "StandardSSD_LRS"
      "Standard_B2s" = "Premium_LRS"
  }
    default_tags = {
      deployedby = "Terraform"
      provider = "azr"
      region = var.location
      create_date = formatdate("DD/MM/YY hh:mm",timeadd(timestamp(),"-3h"))
      modified_in = formatdate("DD/MM/YY hh:mm",timeadd(timestamp(),"-3h"))
  }
  tags = merge(var.tags, local.default_tags)
}