variable "name" {}

variable "create_eip" {
  description = "Controls if EIP should be created "
  type        = bool
}

variable "environment" {
  description = "Environment of the resource"
  default     = ""
}
