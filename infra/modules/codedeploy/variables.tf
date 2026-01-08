variable "project_name" {
  type = string
}

variable "ecs_cluster_name" {
  type = string
}

variable "ecs_service_name" {
  type = string
}

variable "alb_listener_arn" {
  type = string
}

variable "target_group_blue_name" {
  type = string
}

variable "target_group_green_name" {
  type = string
}

variable "termination_wait_time" {
  type        = number
}

variable "deployment_config_name" {
  type        = string
}
