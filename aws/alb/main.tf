resource "aws_s3_bucket_policy" "main" {
  bucket = var.log_bucket_name
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.aws_account_id}:root"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${var.log_bucket_name}/${var.alb_name}/*"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.aws_account_id}:root"
      },
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:::${var.log_bucket_name}"
    }
  ]
}
POLICY
}

resource "aws_lb" "main" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.sg_name
  idle_timeout       = 600
  subnets            = var.public_subnets

  enable_deletion_protection = false

  access_logs {
    bucket  = var.log_bucket_name
    prefix  = var.alb_name
    enabled = true
  }

  tags = {
    name        = var.alb_name
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "http" {
  name     = var.alb_target_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    interval            = var.health_check_interval
    path                = var.health_check_path
    timeout             = var.health_check_timeout
    port                = var.health_check_port
    protocol            = var.health_check_protocol
    matcher             = var.health_check_matcher
  }

  tags = {
    Name        = var.alb_target_name
    Environment = var.environment
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      status_code = "HTTP_301"
      port        = "443"
      protocol    = "HTTPS"
    }
  }

}

resource "aws_lb_listener" "https" {
  count             = var.create_https_tg ? 1 : 0
  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.https_certification_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http.arn
  }
}

resource "aws_lb_listener_rule" "default" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http.arn
  }

  dynamic "condition" {
    for_each = [var.lb_listener_rule_condition]
    content {
      field  = condition.value["field"]
      values = list(condition.value["values"])
    }
  }
}

