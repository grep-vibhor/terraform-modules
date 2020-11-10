# The auto scaling group that specifies how we want to scale the number of EC2 Instances in the cluster

resource "aws_autoscaling_group" "main" {
  name                 = var.name
  target_group_arns    = []
  availability_zones   = var.availability_zones
  vpc_zone_identifier  = var.subnet_ids
  launch_configuration = var.launch_configuration
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity
  health_check_type    = "ELB"
  # target_group_arns    = var.target_arn
  enabled_metrics      = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  termination_policies = ["OldestLaunchConfiguration", "Default"]

  lifecycle {
    create_before_destroy = true
  }
}
