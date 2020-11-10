variable "azs" {}

variable "vpc_id" {}
variable "name" {}

variable "tags" {
  description = "Common service and env tags"
  type        = map(string)
  default     = {}
}
variable "enable_s3_endpoint" {
  description = "provision an ecr api endpoint to the VPC"
  type        = bool
}

variable "private-routetable-id" {}