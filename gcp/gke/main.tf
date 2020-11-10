locals {
  default_oauth_scopes = [
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring",
  ]
}

resource "google_container_cluster" "gcp_kubernetes" {
  provider       = google-beta
  project        = var.service_project_id
  depends_on     = [var.gke_depends_on]
  name           = var.cluster_name
  location       = var.gcp_region
  node_locations = var.gcp_node_locations
 # network        = var.network
  network        = "projects/${var.host_project_id}/global/networks/${var.network}"
  subnetwork     = "projects/${var.host_project_id}/regions/${var.gcp_region}/subnetworks/${var.subnet_name}"

  master_auth {
    username = var.master_username
    password = var.master_password

    client_certificate_config {
      issue_client_certificate = true
    }
  }
  remove_default_node_pool = var.remove_default_node_pool
  initial_node_count       = var.initial_node_count_default
  #master_authorized_networks_config {
  #  cidr_blocks {
  #    cidr_block   = var.cidr_block
  #    display_name = var.display_name
  #  }
  #}

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = var.master_authorized_networks
      content {
        cidr_block   = cidr_blocks.value.cidr_block
        display_name = cidr_blocks.value.display_name
      }
    }
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_subnet_name
    services_secondary_range_name = var.services_subnet_name
  }

  network_policy {
    enabled = true
  }

  networking_mode = "VPC_NATIVE"

  private_cluster_config {
    enable_private_nodes = var.enable_private_nodes
    #enable_private_endpoint = var.enable_private_endpoint
    enable_private_endpoint = var.enable_private_nodes ? "true" : "false"
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
    master_global_access_config {
      enabled = var.master_global_access_config
    }
  }

  resource_labels = {
    team        = var.team
    environment = var.environment
    app         = var.app_name
  }

  min_master_version = var.master_version
  node_version       = var.node_version
  release_channel {
    channel = var.enable_master_version == true ? "UNSPECIFIED" : var.release_channel_name
  }

  maintenance_policy {
    recurring_window {
      start_time = var.start_time_maintenance_window
      end_time   = var.end_time_maintenance_window
      recurrence = var.recurrence_maintenance_window
    }
  }
  vertical_pod_autoscaling {
    enabled = var.vertical_pod_autoscaling
  }

  enable_legacy_abac = var.enable_legacy_abac

  cluster_autoscaling {
    autoscaling_profile = var.autoscaling_profile
    enabled             = var.cluster_autoscaling_enabled
  }

  enable_shielded_nodes = var.enable_shielded_nodes

  default_max_pods_per_node = var.max_pods_per_node

  addons_config {
    http_load_balancing {
      disabled = var.http_load_balancing
    }

    horizontal_pod_autoscaling {
      disabled = var.horizontal_pod_autoscaling
    }

    network_policy_config {
      disabled = var.network_policy_config
    }
  }

}


resource "google_container_node_pool" "pool" {
  count              = length(var.node_pools)
  project            = var.service_project_id
  name               = var.node_pools[count.index]["name"]
  location           = var.cluster_region
  cluster            = google_container_cluster.gcp_kubernetes.name
  initial_node_count = var.node_pools[count.index]["initial_node_count"]

  autoscaling {
    min_node_count = var.node_pools[count.index]["min_node_count"]
    max_node_count = var.node_pools[count.index]["max_node_count"]
  }

  max_pods_per_node = var.node_pools[count.index]["max_pods_per_node"]
  node_locations    = var.node_pools[count.index]["node_locations"]

  node_config {
    metadata = {
      disable-legacy-endpoints = var.disable-legacy-endpoints
    }

    shielded_instance_config {
      enable_secure_boot          = var.enable_secure_boot
      enable_integrity_monitoring = var.enable_integrity_monitoring
    }
    oauth_scopes = var.oauth_scopes

    labels = var.node_pools[count.index]["labels"]
    disk_size_gb    = var.node_pools[count.index]["disk_size"]
    machine_type    = var.node_pools[count.index]["machine_type"]
    image_type      = var.node_pools[count.index]["image_type"]
    preemptible     = var.node_pools[count.index]["preemptible"]
    service_account = var.node_pools[count.index]["service_account"]

    dynamic "taint" {
      for_each = var.node_pools[count.index]["taint_req"] ? { 1 : "one" } : {}
      content {
        key    = var.node_pools[count.index]["taint_key"]
        value  = var.node_pools[count.index]["taint_value"]
        effect = var.node_pools[count.index]["taint_effect"]
      }
    }
  }

  version = var.node_pools[count.index]["auto_upgrade"] == "true" ? null : var.node_version

  management {
    auto_upgrade = var.node_pools[count.index]["auto_upgrade"]
    auto_repair  = var.node_pools[count.index]["auto_repair"]
  }

  upgrade_settings {
    max_surge       = var.max_surge
    max_unavailable = var.max_unavailable
  }
}
