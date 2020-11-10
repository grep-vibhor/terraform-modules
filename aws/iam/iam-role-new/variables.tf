variable "role_name" {
  description = "The name of the IAM Role"
  type        = string
  default     = ""
}

variable "path" {}

variable "role_description" {}

variable "policy" {
  description = "The path of the policy in IAM (tpl file)"
  type        = string
  default     = ""
}

variable "assume_role_policy" {}
variable "permissions_boundary" {}
variable "max_session_duration" {
  default = 28800
}
variable "force_detach_policies" {}
variable "policy_arn" {}
variable "aws_managed_policy" {}

variable "custom_role_policy_arns" {
  description = "List of ARNs of IAM policies to attach to IAM role"
  type        = list(string)
  default     = []
}