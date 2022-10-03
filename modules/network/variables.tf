variable "compute_network_name" {
  type = string
}

variable "project_id" {
  type = string
}

variable "compute_subnetworks" {
  type = map(any)
}
