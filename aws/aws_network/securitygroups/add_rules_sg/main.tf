resource "aws_security_group_rule" "allow_all" {
  type              = "ingress"
  from_port         = var.from_port
  to_port           = var.to_port
  protocol          = "TCP"
  cidr_blocks       = [var.cidr]
  security_group_id = var.sg_id
}
