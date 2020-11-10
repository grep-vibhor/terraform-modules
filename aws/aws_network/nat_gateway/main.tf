###################
# NAT GATEWAY
###################
resource "aws_nat_gateway" "nat" {
  count = var.create_natgw ? 1 : 0
  allocation_id = var.allocation_id[count.index]
  subnet_id = var.public-subnet-id
  tags = {
    Name = var.name
    Environment = var.environment
  }
}
