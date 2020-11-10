data "template_file" "pipeline_params" {
  template = file("${path.module}/parameter_store_variable.json.tpl")

  vars = {
    TF_VERSION       = var.TF_VERSION
    TF_ENV           = var.TF_ENV
    OU_NAME          = var.OU_NAME
    BILLING_ACCESS   = var.BILLING_ACCESS
    BLOOM_ENDPOINT   = var.BLOOM_ENDPOINT
    TF_CLIENT_ID     = var.TF_CLIENT_ID
    TF_CLIENT_SECRET = var.TF_CLIENT_SECRET
    OKTA_URL         = var.OKTA_URL
  }
}

############# Default Parameters   ###############

resource "aws_ssm_parameter" "default" {
  count       = length(var.parameter_write)
  name        = "/api/${var.environment}/${lookup(var.parameter_write[count.index], "name")}"
  description = lookup(var.parameter_write[count.index], "description", lookup(var.parameter_write[count.index], "name"))
  type        = lookup(var.parameter_write[count.index], "type", "SecureString")
  value       = lookup(var.parameter_write[count.index], "value")
  overwrite   = true

  tags = {
    Name        = "/api/${var.environment}/${lookup(var.parameter_write[count.index], "name")}"
    Environment = var.environment
  }
}

resource "aws_ssm_parameter" "pipeline_params" {
  name        = "/api/${var.environment}/aws/pipeline/parameters"
  type        = "String"
  value       = data.template_file.pipeline_params.rendered
  description = "The pipeline parameters json"
  overwrite   = true

  tags = {
    Name        = "/api/${var.environment}/aws/pipeline/parameters"
    Environment = var.environment
  }
}

