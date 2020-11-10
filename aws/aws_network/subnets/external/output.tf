output "public_subnet_ids" {
  value = sort(aws_subnet.public.*.id)
}