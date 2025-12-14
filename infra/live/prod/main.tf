terraform {
  required_version = ">= 1.11, < 2.0"
}

provider "aws" {
  region = var.region
}

module "network" {
  source = "../../modules/network"

  project_name        = var.project_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  az                  = var.az
}

module "security" {
  source = "../../modules/security"

  project_name = var.project_name
  vpc_id       = module.network.vpc_id
  app_port =    var.app_port
}