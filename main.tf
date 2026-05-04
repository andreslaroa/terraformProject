# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Terraform configuration

provider "aws" {
  region = local.common_tags.Region
}

module "aws_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.1"

  name = local.common_tags.Project
  cidr = var.vpc_cidr
  
  azs = ["${var.aws_region}a"]

  private_subnets = var.vpc_private_subnets

  public_subnets     = var.vpc_public_subnets
  enable_nat_gateway = var.vpc_enable_nat_gateway

  tags = local.common_tags

}

module "aws_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.1"

  name   = "${local.prefix}-sg"
  vpc_id = module.aws_vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 80
      protocol    = "tcp"
      description = "http"
      cidr_blocks = "10.10.0.0/16"
    },
    {
      from_port   = 0
      to_port     = 22
      protocol    = "tcp"
      description = "ssh"
      cidr_blocks = "10.10.0.0/16"
    }
  ]


}


module "ec2_instances" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = local.common_tags.Project

  key_name = var.ec2_keyname

  tags = local.common_tags

  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [module.aws_security_group.security_group_id]
  subnet_id              = module.aws_vpc.private_subnets[0]
}

resource "aws_ec2_instance_state" "test" {
  instance_id = module.ec2_instances.id
  state       = "stopped"
}

module "s3-bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "${var.project_name}-${var.environment}-round-robin"

  tags = local.common_tags
}
