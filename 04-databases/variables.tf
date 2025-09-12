variable "project_name" {
  default = "Roboshop"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    Project     = "roboshop"
    Environment = "dev"
    Terraform   = "true"
  }
}

variable "zone_name" {
  default = "mydevops3.online"
}

variable "ec2_name" {
  default = ""

}

variable "zone_id" {
  default = "Z07176522V8YPHJACQNO8"
}