variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "app_port" {
  type = number
}

variable "vpc_cidr" {
  description = "vpc cidr for allowing internal https"
  type        = string
}