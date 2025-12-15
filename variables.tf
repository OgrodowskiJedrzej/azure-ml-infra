variable "resource_group_name" {
    type = string
    description = "Resource group name."
}

variable "location" {
    type = string
    description = "Location of Azure resources"
}

variable "environment" {
    type = string
    description = "Name of environment."
}

variable "cluster_name" {
  type = string
  description = "Name of compute cluster for AML."
}

variable "workspace_name" {
  type = string
}