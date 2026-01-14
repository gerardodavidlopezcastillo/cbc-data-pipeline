output "redshift_cluster_endpoint" {
  description = "Redshift cluster endpoint"
  value       = aws_redshift_cluster.cbcmobility_cluster.endpoint
}

output "redshift_role_arn" {
  description = "Redshift IAM role ARN"
  value       = aws_iam_role.redshift_role.arn
}

output "lambda_role_arn" {
  description = "Lambda IAM role ARN"
  value       = aws_iam_role.lambda_role.arn
}

output "raw_bucket_name" {
  value = aws_s3_bucket.raw_data.bucket
}

output "processed_bucket_name" {
  value = aws_s3_bucket.processed_data.bucket
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.cbc_data_pipeline.repository_url
}

output "ecr_repository_arn" {
  description = "ECR repository ARN"
  value       = aws_ecr_repository.cbc_data_pipeline.arn
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.cbc_cluster.name
}

output "ecs_task_definition_arn" {
  description = "ECS Task Definition ARN"
  value       = aws_ecs_task_definition.cbc_task.arn
}

output "ecs_service_name" {
  description = "ECS Service name"
  value       = aws_ecs_service.cbc_service.name
}
