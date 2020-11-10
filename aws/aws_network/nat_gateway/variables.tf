variable "name" {}
variable "create_natgw" {
  description = "Controls if NATGW should be created "
  type        = bool
}

variable "tags" {
  description = "Common service and env tags"
  type        = map(string)
  default     = {}
}
variable "nat_gateway_tags" {
  description = "Additional tags for the nat gateway tags"
  type        = map(string)
  default     = {}
}

variable "allocation_id" {}

variable "public-subnet-id" {
  description = "A list of public subnets inside the VPC"
}
variable "environment" {
  description = "Environment of the resource"
  default     = ""
}
