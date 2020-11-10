output "elasticache-route-table-id" {
  value = var.attach_natgateway  ? aws_route_table.elasticahe_with_ngw.*.id: aws_route_table.elasticahe_without_ngw.*.id
}
