############################################
# INTERNAL PRIVATE ROUTES WITH NATGATEWAY
#############################################

resource "aws_route_table" "private_with_ngw" {
  count  = var.create_private_route_table ? 1 : 0
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }
  tags = {
    Name        = var.name
    Environment = var.environment
  }
}

resource "aws_route_table_association" "private_with_ngw" {
  count          = var.attach_natgateway ? length(var.private-subnets) : 0
  route_table_id = aws_route_table.private_with_ngw.*.id[0]
  subnet_id      = element(var.private-subnet-ids, count.index)
}
