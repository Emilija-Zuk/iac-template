variable "project_name" {
  description = "name prefix for resources"
  type        = string
}

variable "vpc_cidr" {
  description = "cidr block for the vpc"
  type        = string
}

variable "public_subnet_cidr" {
  description = "cidr block for the public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "cidr block for the private subnet"
  type        = string
}

variable "az" {
  description = "availability zone to use (single az)"
  type        = string
}
