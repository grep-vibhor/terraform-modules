########################################
########### DB Subnet Group ############
########################################

resource "aws_db_subnet_group" "postgresql" {
  name        = "${var.project}-${var.environment}-db-sn-grp"
  description = "rds public subnet group"

  subnet_ids = var.db_subnets

  tags = {
    Name        = "${var.project}-${var.environment}-db-sn-grp"
    environment = var.environment
  }
}