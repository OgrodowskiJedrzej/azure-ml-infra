variable "resource_group_name" {
    type = string
    default = "rg-azure-ml"
    description = "Resource group name."
}

variable "location" {
    type = string
    default = "westeurope"
    description = "Location of Azure resources"
}