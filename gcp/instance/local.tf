locals {
  static_ip_list = google_compute_address.static.*

  static_ip_map = merge({
      for ip in local.static_ip_list :
    ip["name"] => ip["address"]
  })

  instance_list = google_compute_instance.gce_instance.*

  internal_ip_bindings = merge({
  for instance in local.instance_list :
  instance["name"] => instance["network_interface"][0]["network_ip"]
  })

  external_ip_bindings = merge({
  for instance in local.instance_list :
  instance["name"] => instance["network_interface"][0]["access_config"][0]["nat_ip"]
  })
}