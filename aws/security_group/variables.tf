variable "name" {}
variable "from_port" {}
variable "to_port" {}
variable "cidr_blocks" {
  type = list(string)
}
variable "protocol" {}
variable "vpc_id" {}
variable "environment" {}

