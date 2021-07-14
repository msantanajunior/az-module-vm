variable "name" {
  type = string
}
variable "location" {
  type = string
  }

variable "rg_name" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "size" {
  type = string
  default = "Standard_D8s_v4"
}

variable "os_image" {
  type = map(string)
  default = {}
}

variable "nics" {
  type = map(map(string))
  default = {}
}

variable "data_disks" {
  type = map(map(string))
  default = {}
}

variable "availability_set" {
  type = string
  default = null
}

variable "boot_diag" {
  type = string
  default = "https://stpinfractim.blob.core.windows.net/"
}