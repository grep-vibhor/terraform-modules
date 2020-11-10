# @optional
variable "project_id" {}

# @optional
variable "service_name_list" {
  type = list(string)
}

# @optional
variable "disable_dependent_services" {
  default = false
}

# @optional
variable "disable_on_destroy" {
  default = false
}
