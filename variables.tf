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

variable "admin" {
  type = string
  default = "avaadmin"
  sensitive = true
}

variable "password" {
  type = string
  sensitive = true
  validation {
    condition = (length(var.password) >= 8 && 
    can(length((regex("[[:lower:]]+",var.password)))) == true && 
    can(length(regex("[0-9]+",var.password))) == true &&
    can(length(regex("[[:punct:]]+",var.password))) == true
    )
    error_message = "A senha não atende os requisitos mínimos."
  }
}

variable "os_image" {
  type = map(string)
  default = {}
}

variable "nics" {
  type = map(map(string))
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
  default = ""
}