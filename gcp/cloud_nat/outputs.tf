output "name" {
  description = "Name of the Cloud NAT"
  value       = local.name
}

output "nat_ip_allocate_option" {
  description = "NAT IP allocation mode"
  value       = local.nat_ip_allocate_option
}

output "router_name" {
  description = "Cloud NAT router name"
  value       = local.router
}