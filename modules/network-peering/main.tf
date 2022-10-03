resource "google_compute_network_peering" "defualt" {
  for_each = try(var.compute_network_peering, {})

  name                                = "${var.compute_network_name}-2-${each.key}"
  network                             = "projects/${var.project_id}/global/networks/${var.compute_network_name}"
  peer_network                        = "projects/${each.value.peer_network_project_name}/global/networks/${each.value.peer_network_name}"
  export_subnet_routes_with_public_ip = false
  import_subnet_routes_with_public_ip = false
}
