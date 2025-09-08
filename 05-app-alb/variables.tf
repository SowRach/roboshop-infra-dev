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
    Component = "app-alb"
  }
}


variable "zone_id" {
  default = "Z03044631C5X7QPVBUFG0"
}

variable "zone_name" {
  default = "mydevops3.online"
}