variable "project" {
  description = "The name of the project"
}

variable "aws_account_id" {
  description = "The aws account id of your account"
}

variable "aws_region" {}

variable "db_instance_backup_enabled" {
  description = "`MANAGEMENT` `RDS` Enable [this](https://docs.aws.amazon.com/config/latest/developerguide/db-instance-backup-enabled.html) rule."
  default     = 0
}

variable "db_backup_retention_period" {
  description = "For `db_instance_backup_enabled` rule. The minimum retention period for backups"
  default     = ""
}

variable "db_backup_preferred_backup_window" {
  description = "For `db_instance_backup_enabled` rule. time range in which backups are created"
  default     = ""
}

variable "db_backup_read_replicas" {
  description = "For `db_instance_backup_enabled` rule. Evaluates whether backups are enabled for read replicas"
  default     = ""
}

variable "rds_multi_az_support" {
  description = "AVAILABILITY RDS Enable [this](https://docs.aws.amazon.com/config/latest/developerguide/rds-multi-az-support.html) rule"
  default     = true
}

variable "config_name" {
  description = "The name of the AWS Config instance."

  #type        = string
  default = "aws-config"
}

variable "config_aggregator_name" {
  description = "The name of the aggregator."

  #type        = string
  default = "organization"
}

variable "aggregate_organization" {
  description = "Aggregate compliance data by organization"
}

variable "config_logs_prefix" {
  description = "The S3 prefix for AWS Config logs"
  default     = "config"
}

variable "config_max_execution_frequency" {
  description = "The maximum frequency with which AWS Config runs evaluations for a rule"
  default     = "TwentyFour_Hours"

}

variable "config_delivery_frequency" {
  description = "The frequency with which AWS Config delivers configuration snapshots"
  default     = "Six_Hours"

}

variable "acm_days_to_expiration" {
  description = "Specify the number of days before the rule flags the ACM Certificate as noncompliant"
  default     = 14
}


variable "password_require_uppercase" {
  description = "Require at least one uppercase character in password"
  default     = true
}

variable "password_require_lowercase" {
  description = "Require at least one lowercase character in password"
  default     = true
}

variable "password_require_symbols" {
  description = "Require at least one symbol in password"
  default     = true
}

variable "password_require_numbers" {
  description = "Require at least one number in password"
  default     = true
}

variable "password_min_length" {
  description = "Password minimum length."
  default     = 12
}

variable "password_reuse_prevention" {
  description = "Number of passwords before allowing reuse"
  default     = 8
}

variable "password_max_age" {
  description = "Number of days before password expiration"
  default     = 60
}

variable "allow_users_to_change_password" {
  description = "Number of days before password expiration"
  default     = true
}

variable "check_guard_duty" {
  description = "Enable guardduty-enabled-centralized rule"
  default     = true
}

variable "check_rds_public_access" {
  description = "Enable rds-instance-public-access-check rule"
  default     = true
}

variable "check_multi_region_cloud_trail" {
  description = "Enable multi-region-cloud-trail-enabled rule"
  default     = false
}

variable "check_cloud_trail_encryption" {
  description = "Enable cloud-trail-encryption-enabled rule"
  default     = true
}

variable "check_cloud_trail_log_file_validation" {
  description = "Enable cloud-trail-log-file-validation-enabled rule"
  default     = true
}

variable "check_eip_attached" {
  description = "Enable eip-attached rule"
  default     = false
}

variable "check_required_tags" {
  description = "Enable required-tags rule"
  default     = false
}

variable "required_tags_resource_types" {
  description = "Resource types to check for tags"
  default = []
}

variable "required_tags" {
  description = "A map of required resource tags. Format is tagNKey, tagNValue, where N is int. Values are optional."
  default = {}
}
