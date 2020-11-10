###################
# ELASTICACHE SUBNETS
###################
resource "aws_subnet" "elasticache" {
  count = length(var.elasticache_subnets) > 0 && var.create_elasicache_subnets ? length(var.elasticache_subnets) : 0
  vpc_id = var.vpc_id
  availability_zone = element(var.azs, count.index)
  cidr_block = element(concat(var.elasticache_subnets, [""]), count.index)
  tags = merge(
  {
    "Name" = format(
    "%s-${var.elasticache_subnet_suffix}-%s",
    var.name,
    element(var.azs, count.index),
    )
  },
  var.tags,
  var.elasticache_subnet_tags,
  )
}