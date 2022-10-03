# Folder Structure
resource "google_project" "default" {
  project_id          = var.project_id
  name                = var.project_id
  folder_id           = var.folder_id
  billing_account     = var.billing_account
  auto_create_network = false
}

resource "google_compute_shared_vpc_service_project" "default" {
  provider        = google-beta
  host_project    = var.host_project_name
  service_project = google_project.default.name
}

resource "google_project_service" "default" {
  for_each = toset(var.project_service_service)

  project                    = google_project.default.name
  service                    = each.key
  disable_dependent_services = true

  timeouts {
    create = "30m"
    update = "40m"
  }
}

resource "google_project_service_identity" "default" {
  for_each = toset(var.project_service_identity)

  provider = google-beta

  project = google_project.default.name
  service = each.key
}

resource "time_sleep" "wait_30_seconds" {
  create_duration = "30s"

  depends_on = [
    google_project_service_identity.default
  ]
}

resource "google_kms_key_ring" "default" {
  project = google_project.default.name

  name     = "default"
  location = "global"

  depends_on = [
    time_sleep.wait_30_seconds
  ]
}

resource "google_kms_crypto_key" "defualt" {
  name            = "default"
  key_ring        = google_kms_key_ring.default.id
  rotation_period = "7776000s"

  depends_on = [
    time_sleep.wait_30_seconds
  ]
}

# resource "google_kms_key_ring_iam_binding" "defualt" {
#   key_ring_id = google_kms_key_ring.default.id
#   role        = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

#   members = [
#     "user:jane@example.com",
#   ]
# }

# resource "google_cloud_identity_group" "defualt" {
#   display_name = "${var.project_id}@soeldner-consult.de"
#   parent       = "customers/A01b123xz"

#   group_key {
#     id = "${var.project_id}@soeldner-consult.de"
#   }

#   labels = {
#     "cloudidentity.googleapis.com/groups.discussion_forum" = ""
#   }
# }
