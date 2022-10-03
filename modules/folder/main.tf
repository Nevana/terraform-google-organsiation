# Folder Structure
resource "google_folder" "default" {
  display_name = var.folder_name
  parent       = "organizations/${var.folder_parent}"
}

