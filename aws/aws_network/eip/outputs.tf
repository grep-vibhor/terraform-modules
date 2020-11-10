output "eip-id" {
  value = aws_eip.nat_ip.*.id
}