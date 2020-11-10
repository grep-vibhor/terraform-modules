output "private_subnet_ids" {
  value = sort(aws_subnet.private.*.id)
}


