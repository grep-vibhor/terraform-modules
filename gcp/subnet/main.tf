/******************************************
	Subnet configuration
 *****************************************/
resource "google_compute_subnetwork" "subnetwork" {
  count                    = length(var.subnets)
  name                     = var.subnets[count.index]["subnet_name"]
  ip_cidr_range            = var.subnets[count.index]["subnet_ip"]
  region                   = var.subnets[count.index]["subnet_region"]
	depends_on               = [var.subnet_depends_on]
  private_ip_google_access = lookup(var.subnets[count.index], "subnet_private_access", "false")

  dynamic "log_config" {
    for_each = length(lookup(var.subnets[count.index], "log_config", {})) != 0 ? [1] : []
    content {
      aggregation_interval = lookup(var.subnets[count.index]["log_config"], "aggregation_interval", "INTERVAL_5_SEC")
      flow_sampling        = lookup(var.subnets[count.index]["log_config"], "flow_sampling", "0.5")
      metadata             = lookup(var.subnets[count.index]["log_config"], "metadata", "INCLUDE_ALL_METADATA")
    }
  }

  network     = var.network_name
  project     = var.project_id
  description = lookup(var.subnets[count.index], "description", null)

  secondary_ip_range = [
    for range in range(0, length(var.subnets[count.index]["secondary_subnet_range"])) :
    {
      range_name    = var.subnets[count.index]["secondary_subnet_range"][range]["secondary_range_name"]
      ip_cidr_range = var.subnets[count.index]["secondary_subnet_range"][range]["secondary_range_cidr"]
    }
  ]
}
