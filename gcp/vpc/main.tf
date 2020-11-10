/******************************************
	VPC configuration
 *****************************************/
resource "google_compute_network" "network" {
  name                    = var.vpc_network_name
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = var.routing_mode
  project                 = var.host_project_id
  description             = var.description
}

/******************************************
	Shared VPC
 *****************************************/
resource "google_compute_shared_vpc_host_project" "shared_vpc_host_project" {
  count      = var.shared_vpc_required ? 1 : 0
  project    = var.host_project_id
  depends_on = [google_compute_network.network]
}

resource "google_compute_shared_vpc_service_project" "shared_vpc_service_proect" {
  count           = var.shared_vpc_required ? 1 : 0
  host_project    = var.host_project_id
  service_project = var.service_project_id
}

resource "google_compute_firewall" "firewall" {
  count = length(var.network_firewall)
  name    = var.network_firewall[count.index]["name"]
  network = google_compute_network.network.name

  dynamic "allow" {
    for_each = var.network_firewall[count.index]["allow"]
    content {
      protocol = allow.value["protocol"]
      ports    = allow.value["ports"]
    }
  }
#  source_tags = var.network_firewall[count.index]["source_tags"]
  target_tags   = var.network_firewall[count.index]["target_tags"]
  source_ranges = var.network_firewall[count.index]["source_ranges"]
  depends_on = [google_compute_network.network]
}
