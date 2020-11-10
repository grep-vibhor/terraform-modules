variable "azs" {}

variable "vpc_id" {}
variable "name" {}

variable "tags" {
  description = "Common service and env tags"
  type        = map(string)
  default     = {}
}

variable "attach_natgateway" {
  description = "Controls if nat gateway attachment is needed or not"
  type        = bool
}

variable "create_elasticache_route" {
  description = "Controls if internal route is needed or not"
  type        = bool
}

variable "elasticache_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "subnet-ids" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "elasticache_route_table_tags" {
  description = "Additional tags for the elasticache route tables"
  type        = map(string)
  default     = {}
}

variable "elasticache_subnet_suffix" {
  description = "Suffix to append to elasticache routes name"
  type        = string
  default     = "elasticache"
}

variable "gateway_id" {
}

variable "elasticache-subnet-ids" {
  description = "A list of elasticache subnets inside the VPC"
  type        = list(string)
  default     = []
}