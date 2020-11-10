variable "environment" {}
variable "enable_encryption" {}
variable "hash_key" {}
variable "hash_key_type" {}
variable "range_key" {}
variable "range_key_type" {}
variable "enable_streams" {}
variable "stream_view_type" {}
variable "dynamodb_attributes" {}
variable "ttl_attribute" {}
variable "ttl_status" {}
variable "autoscale_write_target" {}
variable "autoscale_read_target" {}
variable "autoscale_min_read_capacity" {}
variable "autoscale_max_read_capacity" {}
variable "autoscale_min_write_capacity" {}
variable "autoscale_max_write_capacity" {}
variable "account_id" {}
variable "table_name" {}

//variable "table_name" {
//  description = "Dynamodb table name (space is not allowed)"
//  type        = list(string)
//  default = [
//    "baselines",
//    "builds",
//    "ventures"
//  ]
//}
