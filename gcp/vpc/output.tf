output "network" {
  value       = google_compute_network.network
  description = "The VPC resource being created"
}

output "network_name" {
  value       = google_compute_network.network.name
  description = "The name of the VPC being created"
}

output "network_self_link" {
  value       = google_compute_network.network.self_link
  description = "The URI of the VPC being created"
}

//output "project_id" {
//  value       = var.shared_vpc_required ? google_compute_shared_vpc_host_project.shared_vpc_host.*.project[0] : google_compute_network.network.project
//  description = "VPC project id"
//}
