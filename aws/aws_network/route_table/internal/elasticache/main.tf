############################################
# INTERNAL ELASTICACHE ROUTES WITH NATGATEWAY
#############################################

resource "aws_route_table" "elasticahe_with_ngw" {
  count = var.attach_natgateway && var.create_elasticache_route ? 1 : 0
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id[count.index]
  }
  tags = merge(
  {
    "Name" = format("%s-${var.elasticache_subnet_suffix}", var.name)
  },
  var.tags,
  var.elasticache_route_table_tags,
  )
}

resource "aws_route_table_association" "elasticache_with_ngw" {
  count = length(var.elasticache_subnets) > 0 && var.attach_natgateway && var.create_elasticache_route ? length(var.elasticache_subnets) : 0
  route_table_id = element(aws_route_table.elasticahe_with_ngw.*.id, count.index)
  subnet_id = element(var.elasticache-subnet-ids, count.index)

}


#################################################
# INTERNAL ELASTICACHE ROUTES WITHOUT NATGATEWAY
#################################################
resource "aws_route_table" "elasticahe_without_ngw" {
  count = var.attach_natgateway ? 0 : 1
  vpc_id = var.vpc_id
  tags = merge(
  {
    "Name" = format("%s-${var.elasticache_subnet_suffix}", var.name)
  },
  var.tags,
  var.elasticache_route_table_tags,
  )
}

resource "aws_route_table_association" "elasticahe_without_ngw" {
  count = length(var.elasticache_subnets) > 0 && var.attach_natgateway ? 0 : length(var.elasticache_subnets)
  route_table_id = element(aws_route_table.elasticahe_without_ngw.*.id, count.index)
  subnet_id = element(var.elasticache-subnet-ids, count.index)
}