#####################################
########### RDS Database ############
#####################################

resource "aws_rds_cluster" "this" {
  cluster_identifier              = "${var.project}-${var.environment}-db-cluster"
  source_region                   = var.aws_region
  engine                          = var.engine
  engine_mode                     = var.engine_mode
  engine_version                  = var.rds_engine_version
  kms_key_id                      = var.kms_key_id
  database_name                   = var.database_name
  master_username                 = var.database_username
  master_password                 = var.database_password
  final_snapshot_identifier       = "${var.project}-${var.environment}-db-final-snapshot"
  skip_final_snapshot             = var.skip_final_snapshot
  deletion_protection             = var.deletion_protection
  backup_retention_period         = var.backup_retention_period
  port                            = var.database_port
  db_subnet_group_name            = aws_db_subnet_group.postgresql.id
  vpc_security_group_ids          = [aws_security_group.rds_sg.id]
  storage_encrypted               = var.storage_encrypted
  copy_tags_to_snapshot           = var.copy_tags_to_snapshot
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  tags = {
    Name        = "${var.project}-${var.environment}-db"
    Environment = var.environment
  }
}

resource "aws_rds_cluster_instance" "this" {
  identifier                 = "${var.project}-${var.environment}-db-instance"
  cluster_identifier         = aws_rds_cluster.this.id
  engine                     = var.engine
  engine_version             = var.rds_engine_version
  publicly_accessible        = var.publicly_accessible
  instance_class             = var.rds_instance_type
  db_subnet_group_name       = aws_db_subnet_group.postgresql.id
  apply_immediately          = var.apply_immediately
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  ca_cert_identifier         = var.ca_cert_identifier

  tags = {
    Name        = "${var.project}-${var.environment}-db-instance"
    Environment = var.environment
  }
}