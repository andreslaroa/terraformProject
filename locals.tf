locals {
  # Naming convention
  common_tags = {
    Company     = var.company_name
    Project     = var.project_name
    Environment = var.environment
    Region      = var.aws_region
  }
  prefix = "${var.project_name}-${var.environment}"

  default_tags = {
    Terraform   = "true"
    Project     = "${var.project_name}"
    Environment = "${var.environment}"
  }
}

