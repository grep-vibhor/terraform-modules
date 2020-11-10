variable "project_id" {
  description = "The ID of the project where subnets will be created"
}

variable "network_name" {
  description = "The name of the network where subnets will be created"
}

variable "subnets" {
  description = "The list of subnets being created"
}

//variable "secondary_ranges" {
//  type        = map(list(object({ range_name = string, ip_cidr_range = string })))
//  description = "Secondary ranges that will be used in some of the subnets"
//  default     = {}
//}

variable "subnet_depends_on" {
  description = "Temp variable, used to make module dependency"
}
