###########################
# VPC Endpoint for ECR API
###########################

data "aws_vpc_endpoint_service" "ecr_api" {
  count = var.enable_ecr_api_endpoint ? 1 : 0
  service = "ecr.api"
}

resource "aws_vpc_endpoint" "ecr_api" {
  count = var.enable_ecr_api_endpoint ? 1 : 0
  service_name = data.aws_vpc_endpoint_service.ecr_api[0].service_name
  vpc_id = var.vpc_id
  security_group_ids = var.securitygroup_id
  vpc_endpoint_type = "Interface"
  subnet_ids = coalescelist(var.ecr_endpoint_subnet_ids,var.private-subnet-ids)
}

###########################
# VPC Endpoint for ECR DKR
###########################

data "aws_vpc_endpoint_service" "ecr_dkr" {
  count = var.enable_ecr_dkr_endpoint ? 1 : 0
  service = "ecr.dkr"
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  count = var.enable_ecr_dkr_endpoint ? 1 : 0
  service_name = data.aws_vpc_endpoint_service.ecr_dkr[0].service_name
  vpc_id = var.vpc_id
  security_group_ids = var.securitygroup_id
  vpc_endpoint_type = "Interface"
  subnet_ids = coalescelist(var.ecr_endpoint_subnet_ids,var.private-subnet-ids)
}