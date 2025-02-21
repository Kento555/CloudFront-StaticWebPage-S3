terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 4.0.0" # Use the latest stable version
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "us_east"
}