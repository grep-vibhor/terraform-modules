
variable "azs" {}
variable "vpc_id" {}
variable "name" {}

variable "create_internal_subnets" {
  description = "Controls if private subnets should be created "
  type        = bool
}
variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "environment" {
  description = "Environment of the resource"
  default     = ""
}

