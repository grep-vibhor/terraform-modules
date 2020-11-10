variable "instance_details" {
  type = map(any)
}
variable "host_project_id" {}
variable "service_project_name" {}
variable "disk_count" {
  default = "4"
}
variable "create-extra-disk" {
  default = "true"
}

variable "instance_depends_on" {
  description = "Temp variable, used to make module dependency"
}
