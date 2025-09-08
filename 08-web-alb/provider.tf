terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta2", # Use the latest beta version for testing
    }
  }

  backend "s3" {
    bucket = "roboshop-dev-stage"
    key    = "web-alb"
    region = "us-east-1"
    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"
}