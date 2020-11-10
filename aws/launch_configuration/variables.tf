variable "name" {
  description = "Launch Config name"
}

variable "instance_type" {
  description = "Instance type"
}

variable "key_name" {
  description = "SSH Key used for EC2"
}

variable "security_groups" {
  description = "Security group to be attached on instance"
  type        = list(string)
}

variable "role_name" {
  description = "IAM Role Name for Instance"
}

variable "userdata" {
  default     = "files/user_data/userdata.sh"
  description = "Userdata shell file name for instance. File path should be in the format of 'files/user_data/userdata_filename' Do not delete the default field option"
}

variable "ami_id" {
  description = "AMI For Launch Config"
}
