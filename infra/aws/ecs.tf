resource "aws_ecs_cluster" "devtest" {
  configuration {
    execute_command_configuration {
      logging = "DEFAULT"
    }
  }

  name = "devtest"

  service_connect_defaults {
    namespace = "arn:aws:servicediscovery:us-east-1:237533616493:namespace/ns-lno7k2x4yyurjfqq"
  }

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_ecs_service" "metabase-1" {
  cluster = "devtest"

  deployment_circuit_breaker {
    enable   = "true"
    rollback = "true"
  }

  deployment_controller {
    type = "ECS"
  }

  deployment_maximum_percent         = "100"
  deployment_minimum_healthy_percent = "50"
  desired_count                      = "2"
  enable_ecs_managed_tags            = "true"
  enable_execute_command             = "false"
  health_check_grace_period_seconds  = "0"
  launch_type                        = "EC2"
  name                               = "metabase-1"

  ordered_placement_strategy {
    field = "attribute:ecs.availability-zone"
    type  = "spread"
  }

  ordered_placement_strategy {
    field = "instanceId"
    type  = "spread"
  }

  scheduling_strategy = "REPLICA"
}

resource "aws_cloudwatch_log_group" "tfer---002F-ecs-002F-metabase" {
  log_group_class = "STANDARD"
  name            = "/ecs/metabase"
  skip_destroy    = "false"
}
