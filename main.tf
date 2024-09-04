terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.credentials.region
  assume_role {
    role_arn     = var.credentials.assume_role_arn
  }
}
