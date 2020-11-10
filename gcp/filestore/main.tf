resource "google_filestore_instance" "filestore_instance" {
  provider   = google-beta
  project    = var.host_project_id
  name = var.filestore_instance_name
  zone = var.filestore_zone
  tier = var.filestore_tier


  file_shares {
    capacity_gb = var.filestore_capacity
    name        = var.file_share_name
  }

  networks {
    network = var.filestore_network
    modes   = var.filestore_ip_version
  }
}
