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
    Component = "cdn"
  }
}


variable "zone_name" {
  default = "mydevops3.online"
}