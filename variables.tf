variable "organization_id" {
  type = string
}

variable "folder_name" {
  type = string
}

variable "host_project_name" {
  type = string
}

variable "service_project_names" {
  type = map(any)
}

variable "billing_account" {
  type = string
}

variable "project_service_service" {
  type = list(any)
}

variable "project_service_identity" {
  type = list(any)
}

variable "compute_networks" {
  type    = map(any)
  default = {}
}
