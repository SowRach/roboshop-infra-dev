# locals {
#   ec2_name = "${var.project_name}-${var.project_environment}"
# }


locals {
          ec2_name = "roboshop-dev-app-alb" # Or derive it from other variables/resources
        }