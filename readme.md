
# Modulo - Linux Virtual Machines
[![Avanade](https://img.shields.io/badge/create%20by-Avanade-orange)](https://www.avanade.com/pt-br/about-avanade) [![HCL](https://img.shields.io/badge/language-HCL-blueviolet)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/provider-Azure-blue)](https://registry.terraform.io/providers/hashicorp/azurerm/latest)

Modulo desenvolvido para facilitar a criação de Linux Virtual Machines

## Compatibilidade de Versão

| Versão do Modulo | Versão Terraform | Versão AzureRM |
|----------------|-------------------| --------------- |
| >= 1.x.x       | 0.14.x            | >= 2.46         |

## Especificando versão

Para evitar que seu código receba atualizações automáticas do modulo, é preciso informar na chave `source` do bloco do module a versão desejada, utilizando o parametro `?ref=***` Não final da url. conforme pode ser visto Não exemplo abaixo.

## Exemplo de uso


```hcl
  module "azrlnx01" {
  source    = "git::https://timbrasil@dev.azure.com/timbrasil/Projeto_IaC/_git/azr-module-lnx_virtual_machine?ref=v1.0.0"
  name = "azrlnx01"
  location = "Brazil South"
  rg_name = "rg_name"
  os_image = {
      sku = "8.2"
    }
  nics = {
    nic1 = {
    subnet_id = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rg_network_name/providers/Microsoft.Network/virtualNetworks/vnet_name/subnets/subnet_name"
    enable_accelerated_networking = "true"
    private_ip_address_allocation = "Dynamic"
    primary = "true"
    }
  }
  data_disks = {
    disk0 = {
      disk_size = "100"
      lun = "0"
      caching = "None"
      zones = "1"
    }
    disk1 = {
      disk_size = "60"
      lun = "1"
      caching = "None"
      zones = "1"
    }
  }
  tags = {
    "region" = "brazilsouth"
  }
}
output "vm_name" {
  value = module.azrlnx01.name
  }
```

## Entrada de Valores

| Nome | Descrição | Tipo | Padrão | Requerido |
|------|-------------|------|---------|:--------:|
| name | nome que será dado ao recusro | `string` | n/a | Sim |
| rg_name | nome do resource group onde os recursos serão alocados | `string` | n/a | Sim |
| tags | Tags adicionais | `map(any)` | `{}` | Não |
| location | região no Azure onde o arquivo será criado | `string` | n/a | Sim |
| data_disks | utilizado para adicionar 1 ou mais discos à VM | `map(map(string)` | n/a | Sim |
| os_image | utilizado pra alterar a versão do SO da VM | `map(string)` | n/a | Sim |
| nics | utilizado para adicionar 1 ou mais Nics à VM | `map(map(string)` | n/a | Sim |



## Saída de Valores

| Nome | Descrição |
|------|-------------|
| vm_name | nome dado ao recurso e ao host |
| nics | exibe todas as nics criadas para à VM |
| vm_public_ip | ips privados atribuidos à VM |

## Documentação de Referência

Terraform Network Interfaces: <br>
[https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface)<br>
Terraform Linux Virtual Machines: <br>
[https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine)<br>
Terraform Managed Disks: <br>
[https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk)


