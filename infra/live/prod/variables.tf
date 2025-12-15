variable "region" {
  description = "aws region"
  type        = string
}

variable "project_name" {
  description = "project name prefix"
  type        = string
}

variable "vpc_cidr" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "app_port" {
  type = number
}

variable "health_check_path" {
  description = "alb target group health check path"
  type        = string
  default     = "/"
}

