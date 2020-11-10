output "instance_static_ip_list" {
  value = local.static_ip_map
}
output "instance_internal_ip" {
  value = local.internal_ip_bindings
}
output "instance_external_ip" {
  value = local.external_ip_bindings
}