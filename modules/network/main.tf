resource "google_compute_network" "default" {
  project                         = var.project_id
  name                            = var.compute_network_name
  routing_mode                    = "GLOBAL"
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
  mtu                             = 1460
}

resource "google_compute_subnetwork" "defualt" {
  for_each = try(var.compute_subnetworks, {})

  project       = var.project_id
  name          = each.key
  ip_cidr_range = each.value.ip_cidr_range
  region        = each.value.region
  network       = google_compute_network.default.id

  dynamic "secondary_ip_range" {
    for_each = try(each.value.secondary_ip_range, {})
    content {
      range_name    = secondary_ip_range.key
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }
}
