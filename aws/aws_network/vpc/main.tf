###################
# VPC
###################
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support
  instance_tenancy = var.instance_tenancy
  tags = {
    Name = var.name
    Environment = var.environment
  }
}
