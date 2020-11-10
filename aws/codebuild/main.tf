resource "aws_codebuild_project" "code_build" {
  name          = var.codebuild_name
  description   = var.codebuild_description
  build_timeout = "60"
  service_role  = var.role_arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type = "NO_CACHE"
  }

  environment {
    compute_type                = var.build_compute_type
    image                       = var.build_image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = var.privileged_mode

    dynamic "environment_variable" {
      for_each = var.environment_variables
      content {
        name  = environment_variable.value.name
        value = environment_variable.value.value
      }
    }
  }

  dynamic "vpc_config" {
    for_each = var.vpc_id == "" ? [] : [var.vpc_id]
    content {
      vpc_id             = var.vpc_id
      subnets            = var.subnet_ids
      security_group_ids = [var.security_group]
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = var.codebuild_log_group
      stream_name = var.codebuild_log_group_stream_name
    }
  }

  source {
    type      = var.repo_identifier
    location  = var.repo_source
    buildspec = var.buildspec
  }

  source_version = var.branch_name

  tags = {
    Name        = var.codebuild_name
    Environment = var.environment
  }

}

resource "aws_codebuild_source_credential" "example" {
  count       = var.repo_identifier == "GITHUB" ? 1 : 0
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  server_type = "GITHUB"
  token       = var.GITHUB_ACCESS_TOKEN
}