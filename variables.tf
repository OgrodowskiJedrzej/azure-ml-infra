variable "resource_group_name" {
    type        = string
    description = "Resource group name."

    validation {
      condition     = length(var.resource_group_name) <= 90
      error_message = "Resource group name length should be less than 90 chars."
    }

    validation {
      condition     = can(regex("^[a-zA-Z0-9._\\-()]+$", var.resource_group_name))
      error_message = "Resource group name contains invalid characters."
    }
}

variable "location" {
    type        = string
    description = "Location of Azure resources"
    default     = "westeurope"
}

variable "environment" {
    type        = string
    description = "Name of environment."
    default     = "dev"
}

variable "cluster_name" {
  type        = string
  description = "Name of compute cluster for AML."
  default     = "azureml_gpu_cluster"
}

variable "cluster_instance_type" {
  type    = string
  default = "Standard_NC4as_T4_v3"

  validation {
    condition = contains(
      [
        "Standard_DS3_v2",         # CPU
        "Standard_DS4_v2",         # CPU
        "Standard_NC4as_T4_v3",    # GPU
        "Standard_NC24ads_A100_v4" # GPU
      ],
      var.cluster_instance_type
    )
    error_message = "Compute Cluster instance must be checked, cost effective."
  }
}

variable "workspace_name" {
  type        = string
  description = "Name of AML workspace."

  validation {
    condition     = length(var.workspace_name) >= 3 && length(var.workspace_name) <= 33
    error_message = "Workspace name must be between 3 and 33 characters."
  }

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$", var.workspace_name))
    error_message = "Workspace name must start with a letter and contain only letters, numbers, and hyphens."
  }
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to resources."
  default = {
    "Environment" = "dev"
    "ManagedBy" = "Terraform"
  }
}

variable "subscription_id" {
  type = string
}