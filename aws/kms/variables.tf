variable "alias_name" {
  description = "The name of the key alias"
}

variable "deletion_window_in_days" {
  description = "The duration in days after which the key is deleted after destruction of the resource"
  default     = 30
}

variable "description" {
  description = "The description of this KMS key"
}

variable "policy" {
  description = "The policy of the key usage"
}
