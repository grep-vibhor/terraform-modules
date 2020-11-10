locals {
  attributes = concat(
    [
      {
        name = var.range_key
        type = var.range_key_type
      },
      {
        name = var.hash_key
        type = var.hash_key_type
      }
    ],
    var.dynamodb_attributes
  )

  # Remove the first map from the list if no `range_key` is provided
  from_index = length(var.range_key) > 0 ? 0 : 1

  attributes_final = slice(local.attributes, local.from_index, length(local.attributes))
}

#################################
######### DYNAMODB ##############
#################################

resource "aws_dynamodb_table" "default" {
  name             = var.table_name
  read_capacity    = var.autoscale_min_read_capacity
  write_capacity   = var.autoscale_min_write_capacity
  hash_key         = var.hash_key
  range_key        = var.range_key
  stream_enabled   = var.enable_streams
  stream_view_type = var.enable_streams ? var.stream_view_type : ""


  server_side_encryption {
    enabled = var.enable_encryption
  }

  dynamic "attribute" {
    for_each = local.attributes_final
    content {
      name = var.hash_key
      type = attribute.value.type
    }
  }
  
  dynamic "attribute" {
    for_each = var.table_name == "policy_execution" ? [var.table_name] : []
    content {
      name = "Account"
      type = "S"
    }
  }
  
  dynamic "attribute" {
    for_each = var.table_name == "policy_execution" ? [var.table_name] : []
    content {
      name = "Name"
      type = "S"
    }
  }

  dynamic "attribute" {
    for_each = var.table_name == "user_verification_status" ? [var.table_name] : []
    content {
      name = "UserId"
      type = "S"
    }
  }

  dynamic "attribute" {
    for_each = var.table_name == "user_verification_status" ? [var.table_name] : []
    content {
      name = "RequestId"
      type = "S"
    }
  }

  #################################
  ### GLOBAL SECONDARY INDEX ######
  #################################

  dynamic "attribute" {
    for_each = var.table_name == "builds" ? [var.table_name] : []
    content {
      name = "VentureID"
      type = "S"
    }
  }

  dynamic "attribute" {
    for_each = var.table_name == "builds" ? [var.table_name] : []
    content {
      name = "CreatedAt"
      type = "S"
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.table_name == "builds" ? [var.table_name] : []
    content {
      name            = "VentureID-CreatedAt-index"
      hash_key        = "VentureID"
      range_key       = "CreatedAt"
      projection_type = "ALL"
      read_capacity   = 10
      write_capacity  = 10
    }
  }

  dynamic "attribute" {
    for_each = var.table_name == "user_verification_status" ? [var.table_name] : []
    content {
      name = "UserId"
      type = "S"
    }
  }

  dynamic "attribute" {
    for_each = var.table_name == "user_verification_status" ? [var.table_name] : []
    content {
      name = "CreatedAt"
      type = "S"
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.table_name == "user_verification_status" ? [var.table_name] : []
    content {
      name            = "UserId-CreatedAt-index"
      hash_key        = "UserId"
      range_key       = "CreatedAt"
      projection_type = "ALL"
      read_capacity   = 5
      write_capacity  = 5
    }
  }

  #################################
  #################################

  ttl {
    attribute_name = var.ttl_attribute
    enabled        = var.ttl_status
  }

  tags = {
    Name        = var.table_name
    Environment = var.environment
  }

  lifecycle {
    ignore_changes = [
      attribute,
      global_secondary_index,
      read_capacity,
      write_capacity,
    ]
  }
}
