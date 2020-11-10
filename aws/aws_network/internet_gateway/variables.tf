variable "vpc_id" {}
variable "name" {}

variable "create_igw" {
  description = "Controls if IGW should be created "
  type        = bool
}
variable "environment" {
  description = "Environment of the resource"
  default     = ""
}
