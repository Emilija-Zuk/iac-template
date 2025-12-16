variable "project_name" {
  type        = string
}

variable "log_retention_days" {
  type        = number
}

variable "region" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "ecs_sg_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "app_port" {
  type = number
}

variable "desired_count" {
  type    = number
}

variable "cpu" {
  type    = number
}

variable "memory" {
  type    = number
}


variable "container_image" {
  type = string
}
