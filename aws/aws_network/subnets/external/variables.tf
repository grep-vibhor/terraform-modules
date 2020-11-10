variable "azs" {}

variable "vpc_id" {}
variable "name" {}

variable "create_external_subnets" {
  description = "Controls if external subnets should be created "
  type        = bool
}
variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "environment" {
  description = "Environment of the resource"
  default     = ""
}

