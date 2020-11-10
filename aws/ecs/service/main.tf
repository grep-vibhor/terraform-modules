resource "aws_cloudwatch_log_group" "main" {
  name              = var.awslogs_group
  retention_in_days = 365
}

####################################
######## ECS Task Definiton ########
####################################

# User data template that specifies how to bootstrap each instance
data "template_file" "container_definitions" {
  template = file("files/task_definitions/bloom.json")
  vars = {
    hostPort          = var.host_port
    containerPort     = var.container_port
    memory            = var.memory
    image             = var.image
    name              = var.container_name
    cpu               = var.cpu
    awslogs_group     = var.awslogs_group
    bloom_environment = var.bloom_environment
    container_name    = var.container_name
    ecr_url           = var.ecr_url
    aws_region        = var.aws_region
  }
}

resource "aws_ecs_task_definition" "main" {
  family                = "${var.name}-ecs-td"
  container_definitions = data.template_file.container_definitions.rendered
  task_role_arn         = var.task_role_arn

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [ap-southeast-1a, ap-southeast-1b, ap-southeast-1c]"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = var.name
    Environment = var.environment
  }
}

#############################
######## ECS Service ########
#############################

resource "aws_ecs_service" "main" {
  depends_on                         = [ null_resource.alb_exists ]
  name                               = "${var.name}-ecs-service"
  cluster                            = var.cluster_name
  task_definition                    = "${aws_ecs_task_definition.main.family}:${max("${aws_ecs_task_definition.main.revision}")}"
  desired_count                      = var.desired_count
  deployment_minimum_healthy_percent = "100"
  deployment_maximum_percent         = "200"
  iam_role                           = var.ecs_service_role

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}

resource "null_resource" "alb_exists" {
  triggers = {
    alb_tg = var.alb_tg
    alb_listener_rule = var.alb_listener_rule
    alb_listener = var.alb_listener
  }
}

