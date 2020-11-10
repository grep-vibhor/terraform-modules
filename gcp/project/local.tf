locals {
  user_email_list = [
    for user in var.user_email_list :
    "user:${user}"
  ]
  group_email_list = [
    for groups in var.group_email_list :
    "group:${groups}"
  ]
  sa_email_list = [
    for sa in var.sa_email_list :
    "serviceAccount:${sa}"
  ]
  email_list = concat(local.user_email_list, local.group_email_list, local.sa_email_list)
}