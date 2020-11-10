data "aws_vpc_endpoint_service" "s3" {
  count = var.enable_s3_endpoint ? 1 : 0
  service = "s3"
}

resource "aws_vpc_endpoint" "s3" {
  count = var.enable_s3_endpoint ? 1 : 0
  vpc_id       = var.vpc_id
  service_name = data.aws_vpc_endpoint_service.s3[count.index].service_name
  vpc_endpoint_type = "Gateway"
}

resource "aws_vpc_endpoint_route_table_association" "private_s3" {
  count = var.enable_s3_endpoint ? 1 : 0
  vpc_endpoint_id = aws_vpc_endpoint.s3[count.index].id
  route_table_id = "${element(var.private-routetable-id, count.index)}"
}