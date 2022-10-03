module "stage-folder" {
  source = "./modules/folder/"

  folder_parent = var.organization_id
  folder_name   = var.folder_name
}

module "host_project" {
  source = "./modules/host-project/"

  project_id               = var.host_project_name
  folder_id                = module.stage-folder.name
  billing_account          = var.billing_account
  project_service_service  = var.project_service_service
  project_service_identity = var.project_service_identity
}

module "service_project" {
  source = "./modules/service-project/"

  for_each = try(var.service_project_names, {})

  project_id               = each.value
  folder_id                = module.stage-folder.name
  billing_account          = var.billing_account
  host_project_name        = module.host-project.name
  project_service_service  = var.project_service_service
  project_service_identity = var.project_service_identity

  depends_on = [
    module.host-project
  ]
}

module "network" {
  source = "./modules/network/"

  for_each = try(var.compute_networks, {})

  project_id           = module.host-project.name
  compute_network_name = each.key
  compute_subnetworks  = try(each.value.compute_subnetworks, {})

  depends_on = [
    module.host-project
  ]
}

module "network_peering" {
  source = "./modules/network-peering"

  for_each = try(var.compute_networks, {})

  project_id              = module.host-project.name
  compute_network_name    = each.key
  compute_network_peering = try(each.value.compute_network_peering, {})

  depends_on = [
    module.network
  ]
}
