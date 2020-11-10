variable "project" {
  type        = string
  description = "Name of project this VPC is meant to house"
}

variable "environment" {
  type        = string
  description = "Name of environment this VPC is targeting"
}

variable "rds_allocated_storage" {
  default     = 100
  type        = number
  description = "Storage allocated to database instance"
}

variable "rds_engine_version" {
  default     = "11.7"
  type        = string
  description = "Database engine version"
}

variable "rds_instance_type" {
  default     = "db.t3.large"
  type        = string
  description = "Instance type for database instance"
}

variable "rds_storage_type" {
  default     = "gp2"
  type        = string
  description = "Type of underlying storage for database"
}

variable "vpc_id" {
  type        = string
  description = "ID of VPC meant to house database"
}

variable "database_username" {
  type        = string
  description = "Name of user inside storage engine"
}

variable "database_password" {
  type        = string
  description = "Database password inside storage engine"
}

variable "database_port" {
  default     = 5432
  type        = number
  description = "Port on which database will accept connections"
}

variable "backup_retention_period" {
  default     = 30
  type        = number
  description = "Number of days to keep database backups"
}

variable "backup_window" {
  # 12:00AM-12:30AM ET
  default     = "04:00-04:30"
  type        = string
  description = "30 minute time window to reserve for backups"
}

variable "maintenance_window" {
  # SUN 12:30AM-01:30AM ET
  default     = "sun:04:30-sun:05:30"
  type        = string
  description = "60 minute time window to reserve for maintenance"
}

variable "auto_minor_version_upgrade" {
  default     = false
  type        = bool
  description = "Minor engine upgrades are applied automatically to the DB instance during the maintenance window"
}

variable "final_snapshot_identifier" {
  default     = "terraform-aws-postgresql-rds-snapshot"
  type        = string
  description = "Identifier for final snapshot if skip_final_snapshot is set to false"
}

variable "skip_final_snapshot" {
  default     = false
  type        = bool
  description = "Flag to enable or disable a snapshot if the database instance is terminated"
}

variable "copy_tags_to_snapshot" {
  default     = true
  type        = bool
  description = "Flag to enable or disable copying instance tags to the final snapshot"
}

variable "multi_availability_zone" {
  default     = false
  type        = bool
  description = "Flag to enable hot standby in another availability zone"
}

variable "storage_encrypted" {
  default     = true
  type        = bool
  description = "Flag to enable storage encryption"
}

variable "monitoring_interval" {
  default     = 0
  type        = number
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected"
}

variable "deletion_protection" {
  default     = false
  type        = bool
  description = "Flag to protect the database instance from deletion"
}

variable "engine" {
  description = "Aurora database engine type, currently aurora, aurora-mysql or aurora-postgresql"
  type        = string
  default     = "aurora-postgresql"
}

variable "engine_mode" {
  description = "The database engine mode. Valid values: global, parallelquery, provisioned, serverless, multimaster."
  type        = string
  default     = "provisioned"
}

variable "database_name" {
  description = "Name for an automatically created database on cluster creation"
  type        = string
}

variable "ca_cert_identifier" {
  description = "The identifier of the CA certificate for the DB instance"
  type        = string
  default     = "rds-ca-2019"
}

variable "apply_immediately" {
  description = "Determines whether or not any DB modifications are applied immediately, or during the maintenance window"
  type        = bool
  default     = true
}

variable "publicly_accessible" {
  description = "Whether the DB should have a public IP address"
  type        = bool
  default     = true
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to export to cloudwatch"
  type        = list(string)
  default     = ["postgresql"]
}

variable "kms_key_id" {}
variable "db_subnets" {}
variable "source_security_group_id" {}

variable "rds_is_multi_az" {
  default = "true"
}

variable "aws_region" {}

variable "bastion_security_group_id" {}
variable "github_app_sg_id" {}