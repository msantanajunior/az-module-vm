data "azurerm_subnet" "subnet" {
  for_each = var.nics
  name                 = element(split("/",each.value.subnet_id),10)
  virtual_network_name = element(split("/",each.value.subnet_id),8)
  resource_group_name  = element(split("/",each.value.subnet_id),4)
}
