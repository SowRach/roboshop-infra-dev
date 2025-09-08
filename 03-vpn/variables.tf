variable "project_name" {
  default = "Roboshop"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    Project = "roboshop"
    Environment = "dev"
    Terraform = "true"
  }
}