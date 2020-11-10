output "private-route-table-id" {
  value = sort(aws_route_table.private_with_ngw.*.id)
}
