variable "vpc_id" {}
variable "name" {}

variable "attach_natgateway" {
  description = "Controls if nat gateway attachment is needed or not"
  type        = bool
}

variable "create_private_route_table" {
  description = "Controls if internal route is needed or not"
  type        = bool
}

variable "gateway_id" {
}

variable "private-subnet-ids" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "private-subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}
variable "environment" {
  description = "Environment of the resource"
  default     = ""
}
