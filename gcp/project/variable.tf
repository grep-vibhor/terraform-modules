variable "project_name" {}
variable "project_id" {}
variable "org_id" {}
variable "role_permission" {
  default     = ["roles/viewer"]
  description = "permission like roles/editor, roles/viewer"
}
variable "user_email_list" {
  type    = list(string)
  default = []
}
variable "group_email_list" {
  type    = list(string)
  default = []
}
variable "sa_email_list" {
  type    = list(string)
  default = []
}
variable "billing_account_id" {
  type = string
}
variable "module_depends_on" {
  description = "Temp variable, used to make module dependency"
}
