variable "host_project_id" {
  description = "The ID of the project where this VPC will be created"
}

variable "service_project_id" {
  description = "The ID of the project where this VPC will be created"
}

variable "network_firewall" {
  description = "Array of firewall rules to be created"
}

variable "vpc_network_name" {
  description = "The name of the network being created"
}

variable "routing_mode" {
  type        = string
  default     = "GLOBAL"
  description = "The network routing mode (default 'GLOBAL')"
}

variable "shared_vpc_required" {
  type        = bool
  description = "Makes this project a Shared VPC host if 'true' (default 'false'). It's requried the host dest project ID"
  default     = false
}

variable "description" {
  type        = string
  description = "An optional description of this resource. The resource must be recreated to modify this field."
  default     = ""
}

variable "auto_create_subnetworks" {
  type        = bool
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources."
  default     = false
}

variable "module_depends_on" {
  description = "Temp variable, used to make module dependency"
}
