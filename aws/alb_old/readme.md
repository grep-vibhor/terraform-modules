# Terraform modules - alb

Module help us creating the alb.

#### Inputs:
```sh
variable "name" {
  description = "AWS ALB Name"
}

variable "internal_lb_value" {
  description="Boolean value if internal load balancer required"
}

variable "entity" {
  description = "Entity Name"
}

variable "environment" {
  description = "Environment Name"
}

variable "subnet_ids" {
  description = "A list of subnet IDs and `this will also decide the availability zones`"
  type        = "list"
}

variable "security_groups" {
  description = "A list of SG IDs"
}

variable "enable_cross_zone_load_balancing" {
  description = "enable_cross_zone_load_balancing boolean, default - false"
}

variable "enable_http2" {
  description = "enable http2 protocal - Boolean value"
}
variable "access_log_bucket_name" {
  description = "S3 bucket in which all logs going to store"
}

variable "enable_access_log" {
  description = "Boolean value for enabling access logs"
}
```

#### Outputs
```sh
output "alb_name" {
  value = "${aws_alb.main.name}"
}
output "alb_arn" {
  value = "${aws_alb.main.arn}"
}
output "dns_name" {
  value = "${aws_alb.main.dns_name}"
}
output "alb_arn_suffix" {
  value = "${aws_alb.main.arn_suffix}"
}
output "alb_zone_id" {
  value = "${aws_alb.main.*.zone_id}"
}
```

#### How to use :
Content for `vraiable.tfvars`
```sh
name="Resource_Name"
internal_lb_value = "true"
entity= "<<PROJECT_NAME>>"
environment = "Playground"
subnet_ids = [""]
security_groups = [""]
enable_cross_zone_load_balancing = false
enable_http2 = "true"
access_log_bucket_name = "test"
enable_access_log = false
```
content for `main.tf`
```sh
module "alb" {
  source = "../modules/alb"
  name = "name"
  internal_lb_value = "true/false"
  security_groups = ["",""]
  enable_cross_zone_load_balancing = "true/false"
  enable_http2 = "true/false"
  subnet_ids = ["",""]
  access_log_bucket_name = ""
  environment = "prod/dev/play"
  enable_access_log = "true/false"
  entity = "<<PROJECT_NAME>>"
}
```
