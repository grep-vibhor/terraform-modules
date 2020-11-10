resource "aws_security_group" "sg" {
  description = var.description
  vpc_id      = var.vpc_id

  tags = {
    Name = var.name
    Environment = var.environment
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "allow_http" {
  type            = "ingress"
  from_port       = 80
  to_port         = 80
  protocol        = "TCP"
  cidr_blocks = [var.cidr]
  security_group_id = aws_security_group.sg.id
}
resource "aws_security_group_rule" "allow_https" {
  type            = "ingress"
  from_port       = 443
  to_port         = 443
  protocol        = "TCP"
  cidr_blocks = [var.cidr]
  security_group_id = aws_security_group.sg.id
}
