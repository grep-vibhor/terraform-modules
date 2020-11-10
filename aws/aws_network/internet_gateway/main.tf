###################
# Internet Gateway
###################
resource "aws_internet_gateway" "internet_gateway" {
  count = var.create_igw ? 1 : 0
  vpc_id = var.vpc_id
  tags = {
    Name = var.name
    Environment = var.environment
  }
}
