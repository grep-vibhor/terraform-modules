resource "aws_alb" "main" {
  name                             = "${var.name}-alb"
  internal                         = var.internal-lb-value
  security_groups                  = var.security-groups
  enable_cross_zone_load_balancing = var.enable-cross-zone-load-balancing
  enable_http2                     = var.enable-http2
  subnets                          = var.subnet-ids
  access_logs {
    bucket  = var.access-log-bucket-name
    prefix  = "alb/${var.environment}/${var.name}"
    enabled = var.enable-access-log
  }

  tags = {
    Name        = "${var.name}-alb"
    Environment = var.environment
    Entity      = var.entity
    Versions    = var.versions
    Owner       = var.owner
    service-name= var.service-name
  }
}

### add target group http
resource "aws_alb_target_group" "http_tg" {
  name     = var.http_tg_name
  port     = var.http_listener_port
  vpc_id   = var.vpc_id
  protocol = var.http_protocol
  tags = {
    Name        = var.http_tg_name
    Environment = var.environment
    Entity      = var.entity
    Versions    = var.versions
    Owner       = var.owner
    service-name= var.service-name
  }
}

### add target group https
resource "aws_alb_target_group" "https_tg" {
  name     = var.https_tg_name
  port     = var.https_listener_port
  protocol = var.https_protocol
  vpc_id   = var.vpc_id
  count    = var.create_https_tg ? 1 : 0
  tags = {
    Name        = var.http_tg_name
    Environment = var.environment
    Entity      = var.entity
    Versions    = var.versions
    Owner       = var.owner
    service-name= var.service-name
  }
}

resource "aws_lb_listener" "port80" {
  load_balancer_arn = aws_alb.main.arn
  port = var.http_listener_port
  protocol = var.http_protocol
  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.http_tg.arn
  }
}
resource "aws_lb_listener" "if_required_port443" {
  count = var.create_https_tg ? 1 : 0
  load_balancer_arn = aws_alb.main.arn
  port = var.https_listener_port
  protocol = var.https_protocol
  certificate_arn = var.https_certification_arn
  default_action {
    type = "forward"
    target_group_arn = var.create_https_tg ? aws_alb_target_group.https_tg[count.index].arn : aws_alb_target_group.http_tg.arn
  }
}
