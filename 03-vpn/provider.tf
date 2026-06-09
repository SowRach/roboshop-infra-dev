terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.37.0", # Use the latest beta version for testing
    }
  }

  backend "s3" {
    bucket = "roboshop-dev-sow"
    key    = "vpn"
    region = "us-east-1"
    # dynamodb_table = "Roboshop-dev-tfstate-locks"
    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"
}

