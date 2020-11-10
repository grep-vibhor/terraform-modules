variable "log_bucket_name" {}
variable "aws_account_id" {}
variable "alb_name" {}
variable "sg_name" {
  type = list(string)
}
variable "public_subnets" {}
variable "alb_target_name" {}
variable "vpc_id" {}
variable "create_https_tg" {}
variable "https_certification_arn" {}
variable "environment" {}
variable "health_check_path" {
  default = "/"
}
variable "health_check_healthy_threshold" {}
variable "health_check_unhealthy_threshold" {}
variable "health_check_interval" {}
variable "health_check_timeout" {}
variable "health_check_port" {}
variable "health_check_protocol" {}
variable "health_check_matcher" {}

variable "lb_listener_rule_condition" {
  description = "The condition for the LB listener rule which is created when `enable_load_balanced` is set."
  type        = map(string)

  default = {
    field  = "path-pattern"
    values = "/*"
  }
}