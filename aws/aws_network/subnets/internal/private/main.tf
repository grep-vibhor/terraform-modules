###################
# PRIVATE SUBNETS
###################

resource "aws_subnet" "private" {
  count             = length(var.private_subnets) > 0 && var.create_internal_subnets ? length(var.private_subnets) : 0
  vpc_id            = var.vpc_id
  availability_zone = element(var.azs, count.index)
  cidr_block        = var.private_subnets[count.index]
  tags = {
    Name              = "${var.name}-${count.index + 1}-${element(var.azs, count.index)}"
    Availability_zone = element(var.azs, count.index)
    Environment       = var.environment
    Tier              = "Private"
  }
}
