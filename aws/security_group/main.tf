resource "aws_security_group" "main" {
  name        = var.name
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = var.protocol
    cidr_blocks = var.cidr_blocks
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.name
    Environment = var.environment
  }
}