###################
# EXTERNAL ROUTES
###################
resource "aws_route_table" "public" {
  count = var.create_external_route_table ? 1 : 0
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }
  tags = {
    Name = var.name
    Environment = var.environment
  }
}


resource "aws_route_table_association" "public" {
    count = var.attach_gateway ? length(var.public-subnets) : 0
  route_table_id = aws_route_table.public.*.id[0]
  subnet_id = element(var.public-subnet-ids, count.index)
}
