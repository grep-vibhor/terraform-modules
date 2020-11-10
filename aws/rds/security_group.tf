##########################################
# security group for rds db-instance
##########################################

resource "aws_security_group" "rds_sg" {
  name        = "${var.project}-${var.environment}-rds-sg"
  vpc_id      = var.vpc_id
  description = "allows incoming http and ssh"

  tags = {
    Name        = "${var.project}-${var.environment}-rds-sg"
    environment = var.environment
  }
}

## ingress rule #1
resource "aws_security_group_rule" "rds-ingress" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = var.source_security_group_id
}

## ingress rule #2
resource "aws_security_group_rule" "rds-ingress-bastion" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = var.bastion_security_group_id
}

## ingress rule #3
resource "aws_security_group_rule" "rds-ingress-lambda" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = var.github_app_sg_id
}

## egress rule #1
resource "aws_security_group_rule" "rds-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds_sg.id
}