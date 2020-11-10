resource "aws_security_group" "sg" {
  description = var.description
  vpc_id      = var.vpc_id

  tags = {
    Name = var.name
    Environment = var.environment
  }
  ingress {
    from_port = var.from_port
    to_port =   var.to_port
    protocol = "TCP"
    cidr_blocks = [var.cidr]
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
