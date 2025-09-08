variable "common_tags" {
  default = {
    Project     = "roboshop"
    Environment = "dev"
    Terraform   = "true"
  }
}

variable "tags" {
  default = {
    Component = "user"
  }
}

variable "project_name" {
  default = "Roboshop"
}
variable "environment" {
  default = "dev"
}

variable "zone_name" {
  default = "mydevops3.online"
}
variable "iam_instance_profile" {
  default = "ShellScriptRoleForRoboshop"
}

variable "aws_region" {
  description = "The AWS region for deployment."
  type        = string
  default     = "us-east-1" # Or your actual region
}