variable "vpc_id" {}
variable "name" {}

variable "create_external_route_table" {
  description = "Controls if internal route is needed or not"
  type        = bool
}
variable "attach_gateway" {
  description = "Controls if internal route is needed or not"
  type        = bool
}

variable "public-subnet-ids" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default = []
}
variable "public-subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default = []
}
variable "gateway_id" {
}
variable "environment" {
  description = "Environment of the resource"
  default     = ""
}
