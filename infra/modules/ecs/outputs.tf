output "cluster_id" {
  value = aws_ecs_cluster.main.id
}

output "cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "log_group_name" {
  value = aws_cloudwatch_log_group.main.name
}

output "ecs_task_execution_role_arn" {
  value = aws_iam_role.main.arn
}

output "service_name" {
  value = aws_ecs_service.main.name
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.main.arn
}
