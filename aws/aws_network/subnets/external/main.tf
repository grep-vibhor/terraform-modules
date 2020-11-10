###################
# PUBLIC SUBNETS
###################

resource "aws_subnet" "public" {
  count                   = length(var.public_subnets) > 0 && length(var.public_subnets) >= length(var.azs) && var.create_external_subnets ? length(var.public_subnets) : 0
  vpc_id                  = var.vpc_id
  availability_zone       = element(var.azs, count.index)
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name              = "${var.name}-${count.index + 1}-${element(var.azs, count.index)}"
    Availability_zone = element(var.azs, count.index)
    Environment       = var.environment
    Tier              = "Public"
  }
}
