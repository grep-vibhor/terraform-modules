
variable "project_id" {
  type        = string
  description = "The GCP project ID"
  default     = null
}

variable "name_prefix" {
  description = "Name prefix for the instance template"
  default     = "default-instance-template"
}

variable "machine_type" {}

variable "can_ip_forward" {
  description = "Enable IP forwarding, for NAT instances for example"
  default     = "false"
}

variable "tags" {
  type        = list(string)
  description = "Network tags, provided as a list"
  default     = []
}

variable "labels" {
  type        = map(string)
  description = "Labels, provided as a map"
  default     = {}
}

variable "preemptible" {
  type        = bool
  description = "Allow the instance to be preempted"
  default     = false
}

variable "region" {
  type        = string
  description = "Region where the instance template should be created."
  default     = null
}

#######
# disk
#######
variable "source_image" {
  description = "Source disk image. If neither source_image nor source_image_family is specified, defaults to the latest public CentOS image."
  default     = "ubuntu-1804-bionic-v20200716"
}

variable "source_image_family" {
  description = "Source image family. If neither source_image nor source_image_family is specified, defaults to the latest public CentOS image."
  default     = "ubuntu-1804-lts"
}

variable "source_image_project" {
  description = "Project where the source image comes from. The default project contains images that support Shielded VMs if desired"
  default     = "ubuntu-os-cloud"
}

variable "disk_size_gb" {
  description = "Boot disk size in GB"
  default     = "20"
}

variable "disk_type" {
  description = "Boot disk type, can be either pd-ssd, local-ssd, or pd-standard"
  default     = "pd-standard"
}

variable "auto_delete" {
  description = "Whether or not the boot disk should be auto-deleted"
  default     = "true"
}

variable "additional_disks" {
  description = "List of maps of additional disks. See https://www.terraform.io/docs/providers/google/r/compute_instance_template.html#disk_name"
  type = list(object({
    auto_delete  = bool
    boot         = bool
    disk_size_gb = number
    disk_type    = string
  }))
  default = []
}

####################
# network_interface
####################
variable "network" {
  description = "The name or self_link of the network to attach this interface to. Use network attribute for Legacy or Auto subnetted networks and subnetwork for custom subnetted networks."
  default     = ""
}

variable "subnetwork" {
  description = "The name of the subnetwork to attach this interface to. The subnetwork must exist in the same region this instance will be created in. Either network or subnetwork must be provided."
  default     = ""
}

variable "subnetwork_project" {
  description = "The ID of the project in which the subnetwork belongs. If it is not provided, the provider project is used."
  default     = ""
}

###########
# metadata
###########

variable "startup_script" {
  description = "User startup script to run when instances spin up"
  default     = ""
}

variable "metadata" {
  type        = map(string)
  description = "Metadata, provided as a map"
  default     = {}
}

##################
# service_account
##################
variable "service_account" {
  type = object({
    scopes = set(string)
  })
  description = "Service account to attach to the instance. See https://www.terraform.io/docs/providers/google/r/compute_instance_template.html#service_account."
}

###########################
# Shielded VMs
###########################
variable "enable_shielded_vm" {
  default     = false
  description = "Whether to enable the Shielded VM configuration on the instance. Note that the instance image must support Shielded VMs. See https://cloud.google.com/compute/docs/images"
}

variable "shielded_instance_config" {
  description = "Not used unless enable_shielded_vm is true. Shielded VM configuration for the instance."
  type = object({
    enable_secure_boot          = bool
    enable_vtpm                 = bool
    enable_integrity_monitoring = bool
  })

  default = {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }
}

###########################
# Public IP
###########################
variable "access_config" {
  description = "Access configurations, i.e. IPs via which the VM instance can be accessed via the Internet."
  type = list(object({
    nat_ip       = string
    network_tier = string
  }))
  default = []
}

variable "template_depends_on" {
  description = "Temp variable, used to make module dependency"
}
