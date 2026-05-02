# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Terraform configuration

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.1"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  
  public_subnets = var.vpc_public_subnets
  enable_nat_gateway = var.vpc_enable_nat_gateway

  tags = var.vpc_tags

}

module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance-terraform"

  key_name      = "events-app-key"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = "t3.micro"
  vpc_security_group_ids = ["sg-00aa1d4c9cbb69dbf"]
  subnet_id              = "subnet-0f4cfcfd497e41851"
}

module "s3-bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "robin-test-may-01-2026"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
