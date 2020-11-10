variable "name" {
  description = "Auto scaling group name - asg will be appand"
}

variable "launch_configuration" {
  description = "Name of the launch configuration"
}

variable "desired_capacity" {
  default = "2"
}

variable "max_size" {
  description = "Max no of instances in the asg can be possible"
}

variable "min_size" {
  description = "Min no of instances in the asg can be possible"
}

variable "availability_zones" {}

variable "subnet_ids" {}

variable "logrotate" {
  description = "for s3 logrotate yes/no, Script will check if the instance is having this tag then only lograte will work"
}