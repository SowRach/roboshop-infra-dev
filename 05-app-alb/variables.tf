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
  default = "Z07176522V8YPHJACQNO8"
}

variable "zone_name" {
  default = "mydevops3.online"
}