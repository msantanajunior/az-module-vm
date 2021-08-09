resource "azurerm_network_interface" "nic" {
  for_each = var.nics
  name = lower("${var.name}_${each.key}")
  location = var.location
  resource_group_name = var.rg_name
  enable_accelerated_networking = lookup(each.value, "enable_accelerated_networking", "false")
  ip_configuration {
    name = "ipconfig1"
    subnet_id = data.azurerm_subnet.subnet[each.key].id
    private_ip_address_version = lookup(each.value, "private_ip_address_version", "IPv4")
    public_ip_address_id = lookup(each.value, "public_ip_address_id", null)
    primary = lookup(each.value, "primary", "false")
    private_ip_address_allocation = lookup(each.value, "private_ip_address_allocation", "Dynamic")
  }
  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags["create_date"]
    ]
  }
}
resource "azurerm_linux_virtual_machine" "vm" {
  depends_on = [
    azurerm_network_interface.nic
  ]
  name = lower(var.name)
  computer_name = var.name
  resource_group_name = var.rg_name
  location = var.location
  size = var.size
  admin_username = var.admin
  admin_password = var.password
  disable_password_authentication = false
  #encryption_at_host_enabled = true
  network_interface_ids = values(azurerm_network_interface.nic)[*].id 
  os_disk {
    caching = "ReadWrite"
    storage_account_type = lookup(local.sizes, var.size)
  }
  source_image_reference {
    publisher = lookup(var.os_image, "publisher","RedHat")
    offer = lookup(var.os_image,"offer","RHEL")
    sku = lookup(var.os_image,"sku","8.2")
    version = lookup(var.os_image,"version","latest")
  }
  boot_diagnostics {
    storage_account_uri = var.boot_diag
  }
  additional_capabilities {
    ultra_ssd_enabled = lookup(local.sizes, var.size) == "Premium_LRS" ? "true" : null
  }
  availability_set_id = var.availability_set
  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags["create_date"]
    ]
  }
}
resource "azurerm_managed_disk" "disk" {
  for_each = var.data_disks
  name = lower("${var.name}_${each.key}")
  location = var.location
  resource_group_name = var.rg_name
  storage_account_type =  lookup(each.value, "storage_account_type", "StandardSSD_LRS")
  create_option = "Empty"
  disk_size_gb = lookup(each.value, "disk_size", "20")
  disk_iops_read_write = lookup(each.value, "iops", "500")
  disk_mbps_read_write = lookup(each.value, "mbps", "60")
  zones = lookup(each.value, "zones", null) != null ? split(",",lookup(each.value, "zones")) : null 
  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags["create_date"]
    ]
  }
}
resource "azurerm_virtual_machine_data_disk_attachment" "disk_attach" {
  for_each = var.data_disks
  managed_disk_id = azurerm_managed_disk.disk[each.key].id
  virtual_machine_id = azurerm_linux_virtual_machine.vm.id
  lun = lookup(each.value, "lun", index((keys(var.data_disks)),each.key))
  caching = lookup(each.value, "caching", "None")
}