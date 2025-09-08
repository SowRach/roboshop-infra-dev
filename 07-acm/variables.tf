variable "environment" {
  default = "dev"
}

variable "project_name" {
  default = "Roboshop"

}

variable "common_tags" {
  default = {
    Project     = "roboshop"
    Environment = "dev"
    Terraform   = "true"
  }
}

variable "tags" {
  default = {
    Component = "acm"
  }
}