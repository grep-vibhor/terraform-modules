variable "rule_name" {}
variable "rule_description" {}
variable "event_pattern" {}
variable "schedule_expression" {}
variable "target_id" {}
variable "target_arn" {}
variable "is_enabled" {
  default = "true"
}
variable "rule_role_arn" {}