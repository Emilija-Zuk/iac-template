terraform {
  required_version = ">= 1.11, < 2.0"
}

provider "aws" {
  region = var.region
}

module "network" {
  source = "../../modules/network"

  project_name          = var.project_name
  vpc_cidr              = var.vpc_cidr
  azs                   = var.azs
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
}

module "security" {
  source = "../../modules/security"

  project_name = var.project_name
  vpc_id       = module.network.vpc_id
  app_port =    var.app_port
}

module "alb" {
  source = "../../modules/alb"

  project_name      = var.project_name
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids

  alb_sg_id         = module.security.alb_sg_id

  app_port       = var.app_port
  health_check_path = var.health_check_path
}

module "ecr" {
  source = "../../modules/ecr"
  project_name = var.project_name
}

module "ecs" {
  source = "../../modules/ecs"
  project_name        = var.project_name
  log_retention_days  = var.log_retention_days
}
