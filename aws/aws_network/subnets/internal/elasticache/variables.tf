variable "azs" {}

variable "vpc_id" {}
variable "name" {}

variable "tags" {
  description = "Common service and env tags"
  type        = map(string)
  default     = {}
}
variable "create_elasicache_subnets" {
  description = "Controls if elasticache subnets should be created "
  type        = bool
}


variable "elasticache_subnets" {
  description = "A list of elasticcache subnets inside the VPC"
  type        = list(string)
  default     = []
}
variable "elasticache_subnet_tags" {
  description = "Additional tags for the elasticcahe subnet"
  type        = map(string)
  default     = {}
}

variable "elasticache_subnet_suffix" {
  description = "Suffix to append to private subnets name"
  type        = string
  default     = "elasticcahe"
}