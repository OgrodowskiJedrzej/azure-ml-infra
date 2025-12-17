variable "workspace_id" {
    type = string
    default = "ID of AML workspace."
}
variable "cluster_name" {
  type        = string
  description = "Name of compute cluster for AML."
}
variable "location" {
    type        = string
    description = "Location of Azure resources"
}
variable "vm_size" {
  type    = string
  validation {
    condition = contains(
      [
        "Standard_DS3_v2",         # CPU
        "Standard_DS4_v2",         # CPU
        "Standard_NC4as_T4_v3",    # GPU
        "Standard_NC24ads_A100_v4" # GPU
      ],
      var.vm_size
    )
    error_message = "Compute Cluster instance must be checked, cost effective."
  }
}