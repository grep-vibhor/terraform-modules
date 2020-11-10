resource "aws_ecr_repository" "main" {
  name                 = var.name
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration  {
    scan_on_push = true
  }

  tags = {
    Name          = var.name
    Environment   = var.environment
  }
}



resource "aws_ecr_lifecycle_policy" "policy" {
  repository = aws_ecr_repository.main.name
  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images if count is more than ${var.ecr_image_count}",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": ${var.ecr_image_count}
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}