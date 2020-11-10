output "igw-id" {
  value = aws_internet_gateway.internet_gateway.*.id
}