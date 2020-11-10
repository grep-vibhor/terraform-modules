output "pubic-route-table-id" {
  value = sort(aws_route_table.public.*.id)
}