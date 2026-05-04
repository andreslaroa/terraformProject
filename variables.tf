# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Input variable definitions
variable "company_name" {
  description = "Company name"
  type = string
  default = "andreslaroa"
}

variable "project_name" {
  description = "Project name"
  type = string
  default = "terraform"
}

variable "environment" {
  description = "Environment type"
  type = string
  default = "test"
}

variable "aws_region" {
  description = "AWS region where resources will be created"
  type = string
  default = "us-east-1"
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = "terraform"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.10.0.0/16"
}

variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list(string)
  default     = ["us-east-1a"]
}

variable "vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
  default     = ["10.10.2.0/24"]
}

variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["10.10.128.0/24", "10.10.129.0/24"]
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type        = bool
  default     = true
}

variable "vpc_security_group_ids" {
  description = "Security groups id of the VPC"
  type = list
  default = ["sg-00aa1d4c9cbb69dbf"]
}

variable "ec2_keyname"{
  description = "Name of the key used to create the EC2"
  type = string
  default = "events-app-key"
}
