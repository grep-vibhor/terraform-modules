###################
# Elastic IP
###################
resource "aws_eip" "nat_ip" {
  count = var.create_eip ? 1 : 0
  vpc        = true
  tags = {
    Name = var.name
    Environment = var.environment
  }
}
