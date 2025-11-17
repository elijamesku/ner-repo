resource "aws_iam_role" "ecs_task_execution" {
  name = "nextjs-ecs-task-execution-role"
  assume_role_policy = jsonencode({
  Version = "2012-10-17"
  Statement = "[{'Action': 'sts:AssumeRole', 'Effect': 'Allow', 'Principal': {'Service': 'ecs-tasks.amazonaws.com'}}]"
})
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
  tags = {
    Name = "nextjs-ecs-task-execution-role"
    Environment = "production"
  }
}

resource "aws_iam_role" "ecs_task" {
  name = "nextjs-ecs-task-role"
  assume_role_policy = jsonencode({
  Version = "2012-10-17"
  Statement = "[{'Action': 'sts:AssumeRole', 'Effect': 'Allow', 'Principal': {'Service': 'ecs-tasks.amazonaws.com'}}]"
})
  tags = {
    Name = "nextjs-ecs-task-role"
    Environment = "production"
  }
}
