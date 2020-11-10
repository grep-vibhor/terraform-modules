
output "elastic-cache-subnet-ids" {
  value = aws_subnet.elasticache.*.id
}
