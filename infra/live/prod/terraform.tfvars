region       = "ap-southeast-2"

project_name = "iac-template"

vpc_cidr = "10.20.0.0/20"

azs = ["ap-southeast-2a", "ap-southeast-2b"]

public_subnet_cidrs  = ["10.20.0.0/24", "10.20.2.0/24"]
private_subnet_cidrs = ["10.20.1.0/24", "10.20.3.0/24"]

app_port = 8000

health_check_path = "/health"

log_retention_days = 7