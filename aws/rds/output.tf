output "this_rds_cluster_arn" {
  value = aws_rds_cluster.this.arn
}

output "this_rds_cluster_id" {
  value = aws_rds_cluster.this.id
}

output "this_rds_cluster_resource_id" {
  value = aws_rds_cluster.this.cluster_resource_id
}

output "this_rds_cluster_endpoint" {
  value = aws_rds_cluster.this.endpoint
}

output "this_rds_cluster_reader_endpoint" {
  value = aws_rds_cluster.this.reader_endpoint
}

# aws_rds_cluster_instance
output "this_rds_cluster_instance_endpoints" {
  value = aws_rds_cluster_instance.this.endpoint
}

output "this_rds_cluster_instance_ids" {
  value = aws_rds_cluster_instance.this.*.id
}

output "db_subnet_id" {
  value = join("", aws_db_subnet_group.postgresql.*.id)
}

output "db_sg_id" {
  value = join("", aws_security_group.rds_sg.*.id)
}