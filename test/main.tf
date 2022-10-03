resource "random_id" "this" {
  byte_length = 4
}

locals {
  project_service_service = [
    "appengine.googleapis.com",
    "artifactregistry.googleapis.com",
    "bigquery.googleapis.com",
    "cloudkms.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "pubsub.googleapis.com",
    "iamcredentials.googleapis.com",
    "cloudbuild.googleapis.com",
    "compute.googleapis.com",
    "storage-api.googleapis.com",
    "container.googleapis.com",
    "iam.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "oslogin.googleapis.com",
    "servicemanagement.googleapis.com",
    "servicenetworking.googleapis.com",
    "serviceusage.googleapis.com",
    "sqladmin.googleapis.com",
    "sql-component.googleapis.com",
    "storage.googleapis.com",
  ]
  project_service_identity = [
    "artifactregistry.googleapis.com",
    "bigquery.googleapis.com",
    "cloudkms.googleapis.com",
    "pubsub.googleapis.com",
    "cloudbuild.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "servicenetworking.googleapis.com",
  ]
}

module "stage-deployment" {
  source = "../"

  billing_account          = "your-billing-account"
  organization_id          = "your-org-id"
  project_service_service  = local.project_service_service
  project_service_identity = local.project_service_identity

  folder_name = "ci-test2"

  host_project_name = "host-project-0003"

  service_project_names = {
    1 = "service-project-01-0002"
  }

  compute_networks = {
    "frontend" = {
      compute_subnetworks = {
        "frontent0001" = {
          ip_cidr_range = "10.0.1.0/24"
          region        = "europe-west1"
        }
        "frontent0002" = {
          ip_cidr_range = "10.0.2.0/24"
          region        = "europe-west2"
        }
      }
      compute_network_peering = {
        "backend" = {
          peer_network_project_name = "host-project-0003"
          peer_network_name         = "backend"
        }
      }
    },
    "backend" = {
      compute_subnetworks = {
        "backend0001" = {
          ip_cidr_range = "10.0.3.0/24"
          region        = "europe-west1"
        }
        "backend0002" = {
          ip_cidr_range = "10.0.4.0/24"
          region        = "europe-west2"
        }
      }
      compute_network_peering = {
        "frontend" = {
          peer_network_project_name = "host-project-0003"
          peer_network_name         = "frontend"
        }
      }
    }
  }
}
