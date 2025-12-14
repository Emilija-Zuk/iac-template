variable "project_name" {
  description = "name prefix for resources"
  type        = string
}

variable "vpc_cidr" {
  description = "cidr block for the vpc"
  type        = string
}

variable "azs" {
  description = "availability zones to use"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "public subnet cidrs"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "private subnet cidrs"
  type        = list(string)
}
