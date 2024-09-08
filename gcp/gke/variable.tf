variable "gcp_project" {
  default = "sandbox"
}

variable "gcp_region" {
  default = "asia-south1"
}

variable "credentials_path" {
  default = "creds.json"
}

variable "service_project_id" {
  default = "sandbox"
}

variable "gcp_location" {
  default = ""
}

variable "host_project_id" {
  default = "devops-sandbox-20200519"
}

variable "workload_identity_name" {
  default = "devops-sandbox-20200519"
}

variable "app_name" {
  default = ""
}

variable "enable_private_nodes" {
  default = false
}

variable "master_global_access_config" {
  default = "true"
}

variable "autoscaling_profile" {
  default = ""
}

variable "cluster_autoscaling_enabled" {
  default = ""
}

variable "auto_provisioning_defaults_min_cpu_platform" {
  default = ""
}

variable "auto_provisioning_defaults_oauth_scopes" {
  default = ""
}

variable "resource_limits_cpu_maximum" {
  default = ""
}

variable "resource_limits_cpu_minimum" {
  default = ""
}

variable "resource_limits_resource_type1" {
  default = ""
}

variable "resource_limits_memory_maximum" {
  default = ""
}

variable "resource_limits_memory_minimum" {
  default = ""
}

variable "resource_limits_resource_type2" {
  default = ""
}

variable "vertical_pod_autoscaling" {
  default = ""
}

variable "release_channel_name" {
  default = ""
}

variable "http_load_balancing" {
  default = ""
}

variable "horizontal_pod_autoscaling" {
  default = ""
}

variable "network_policy_config" {
  default = ""
}

variable "enable_private_endpoint" {
  default = true
}

variable "cluster_ipv4_cidr_block" {
  default = "10.2.0.0/16"
}

variable "services_ipv4_cidr_block" {
  default = "10.241.0.0/22"
}

variable "enable_release_channel" {
  default = "false"
}

variable "master_username" {
  default = "admin"
}

variable "master_password" {
  default = "admin-password456789%"
}

variable "cluster_name" {
  default = "test-gke-tf-eli"
}

variable "cluster_region" {
  default = "asia-south1"
}

variable "network" {
  default = ""
}

variable "subnet_name" {
  default = "default"
}

variable "pods_subnet_name" {
  default = "default"
}

variable "services_subnet_name" {
  default = "default"
}

variable "team" {
  default = "devops"
}

variable "environment" {
  default = "test"
}

variable "master_version" {
  default = "1.15.12-gke.20"
}

variable "node_version" {
  default = "1.15.12-gke.20"
}

variable "start_time_maintenance_window" {
  default = "2020-04-10T09:00:00+05:30"
}

variable "end_time_maintenance_window" {
  default = "2020-04-10T17:00:00+05:30"
}

variable "recurrence_maintenance_window" {
  default = "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH"
}

variable "enable_legacy_abac" {
  default = "false"
}

variable "remove_default_node_pool" {
  default = ""
}

variable "disable-legacy-endpoints" {
  default = ""
}

variable "enable_master_version" {
  default = ""
}

variable "enable_integrity_monitoring" {
  default = ""
}

variable "enable_secure_boot" {
  default = ""
}

variable "node_pools_devops_count" {
  default = ""
}

variable "gcp_node_locations" {
  type    = list(string)
  default = ["asia-south1-a", "asia-south1-b"]
}

variable "oauth_scopes" {
  type    = list(string)
  default = ["https://www.googleapis.com/auth/cloud-platform"]
}

variable "node_pools" {
  description = "Node pools information"
  type        = list(any)

  default = [
    {
      name              = "ghr-general-purpose-1"
      machine_type       = "n1-standard-4"
      disk_size          = "30"
      min_node_count     = "1"
      max_node_count     = "4"
      node_locations     = ["asia-south1-a", "asia-south1-c"]
      initial_node_count = "3"
      max_pods_per_node  = "50"
      auto_upgrade       = "true"
      auto_repair        = "true"
      image_type         = "cos"
      preemptible        = "false"
      service_account    = "greythr-tf@office-k8s-workloads-204411.iam.gserviceaccount.com"
      taint_req          = true
      taint_key          = "taints.k8s.gtkops.in/role"
      taint_value        = "greythr"
      taint_effect       = "NO_SCHEDULE"
      labels = { "instance-type" = "m5.xlarge"
        "life-cycle"    = "normal"
        "role"          = "greythr"
        "volume-type"   = "nvme"
        "instancegroup" = "ghr-m5-xlarge"
      }

    }
  ]

}

variable "node_pools_devops" {
  description = "Node pools information"
  type        = list(any)

  default = [
    {
      name               = "ghr-general-purpose-1"
      machine_type       = "n1-standard-4"
      disk_size          = "30"
      min_node_count     = "1"
      max_node_count     = "4"
      node_locations     = ["asia-south1-a", "asia-south1-c"]
      initial_node_count = "3"
      max_pods_per_node  = "50"
      auto_upgrade       = "true"
      auto_repair        = "true"
      image_type         = "cos"
      preemptible        = "false"
      service_account    = "greythr-tf@office-k8s-workloads-204411.iam.gserviceaccount.com"
    }
  ]

}

variable "node_pools_count" {
  description = "Number of node pools information"
  default     = "2"
}

variable "initial_node_count" {
  default = ""
}

variable "max_surge" {}

variable "max_unavailable" {}

variable "enable_shielded_nodes" {}

variable "max_pods_per_node" {}

variable "master_ipv4_cidr_block" {}

variable "node_tag" {
  description = "Tag for normal node pool"
  default = []
}

variable "initial_node_count_default" {
  default = ""
}

variable "database_encryption" {
  description = "Application-layer Secrets Encryption settings. The object format is {state = string, key_name = string}. Valid values of state are: \"ENCRYPTED\"; \"DECRYPTED\". key_name is the name of a CloudKMS key."
  type        = list(object({ state = string, key_name = string }))
  default = [{
    state    = "DECRYPTED"
    key_name = ""
  }]
}

variable "master_authorized_networks" {
  type        = list(object({ cidr_block = string, display_name = string }))
  description = "List of master authorized networks. If none are provided, disallow external access (except the cluster node IPs, which GKE automatically whitelists)."
  default     = []
}

variable "gke_depends_on" {
  description = "Temp variable, used to make module dependency"
}
