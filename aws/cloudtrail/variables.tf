variable "s3_bucket_name" {
  description = "S3 Bucket name"
}

variable "account" {
  description = "Account id"
}
variable "enable_logging" {}
variable "is_multi_region_trail" {}
variable "enable_log_file_validation" {}
variable "is_organization_trail" {}
variable "cloud_watch_logs_role_arn" {}
variable "cloud_watch_logs_group_arn" {}
variable "kms_key_arn" {}
variable "include_global_service_events" {}
