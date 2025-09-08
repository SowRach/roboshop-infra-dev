module "vpn" {

  source       = "../../terraform-aws-security-group"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_vpc.default.id
  sg_name      = "vpn"
}

module "mongodb" {

  source       = "../../terraform-aws-security-group"
  environment  = var.environment
  project_name = var.project_name
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_name      = "mongodb"
}

module "catalogue" {

  source       = "../../terraform-aws-security-group"
  environment  = var.environment
  project_name = var.project_name
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_name      = "catalogue"
}

module "user" {

  source       = "../../terraform-aws-security-group"
  environment  = var.environment
  project_name = var.project_name
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_name      = "user"
}

module "shipping" {

  source       = "../../terraform-aws-security-group"
  environment  = var.environment
  project_name = var.project_name
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_name      = "shipping"
}

module "payments" {

  source       = "../../terraform-aws-security-group"
  environment  = var.environment
  project_name = var.project_name
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_name      = "payments"
}

module "mysql" {

  source       = "../../terraform-aws-security-group"
  environment  = var.environment
  project_name = var.project_name
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_name      = "mysql"
}

module "redis" {

  source       = "../../terraform-aws-security-group"
  environment  = var.environment
  project_name = var.project_name
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_name      = "redis"
}
module "rabbitmq" {

  source       = "../../terraform-aws-security-group"
  environment  = var.environment
  project_name = var.project_name
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_name      = "rabbitmq"
}

module "cart" {

  source       = "../../terraform-aws-security-group"
  environment  = var.environment
  project_name = var.project_name
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_name      = "cart"
}
module "web" {

  source       = "../../terraform-aws-security-group"
  environment  = var.environment
  project_name = var.project_name
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_name      = "web"
}

module "raiting" {

  source       = "../../terraform-aws-security-group"
  environment  = var.environment
  project_name = var.project_name
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_name      = "raiting"
}

module "app_alb" {

  source       = "../../terraform-aws-security-group"
  environment  = var.environment
  project_name = var.project_name
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_name      = "app_alb"
}

module "web_alb" {

  source       = "../../terraform-aws-security-group"
  environment  = var.environment
  project_name = var.project_name
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_name      = "web_alb"
}

# #openvpn
# resource "aws_security_group_rule" "vpn_home" {
#   security_group_id = module.vpn.sg_id
#   type              = "ingress"
#   from_port         = 0
#   to_port           = 65535
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/0"] #ideally your home public IP address, but it frequently changes
# }

# #mongodb

# #mongodb accepting connections from catalogue instance
# resource "aws_security_group_rule" "mongodb_catalogue" {
#   source_security_group_id = module.catalogue.sg_id
#   type                     = "ingress"
#   from_port                = 27017
#   to_port                  = 27017
#   protocol                 = "tcp"
#   security_group_id        = module.mongodb.sg_id
# }

# #mongodb accepting connections from user instance
# resource "aws_security_group_rule" "mongodb_user" {
#   source_security_group_id = module.user.sg_id
#   type                     = "ingress"
#   from_port                = 27017
#   to_port                  = 27017
#   protocol                 = "tcp"
#   security_group_id        = module.mongodb.sg_id
# }

# #mongodb accepting connections from vpn instance
# resource "aws_security_group_rule" "mongodb_vpn" {
#   source_security_group_id = module.vpn.sg_id
#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   security_group_id        = module.mongodb.sg_id
# }

# #redis

# #redis accepting connections from user instance
# resource "aws_security_group_rule" "redis_user" {
#   source_security_group_id = module.user.sg_id
#   type                     = "ingress"
#   from_port                = 6379
#   to_port                  = 6379
#   protocol                 = "tcp"
#   security_group_id        = module.redis.sg_id
# }


# #redis accepting connections from VPN instance
# resource "aws_security_group_rule" "redis_VPN" {
#   source_security_group_id = module.vpn.sg_id
#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   security_group_id        = module.redis.sg_id
# }

# #redis accepting connections from cart instance
# resource "aws_security_group_rule" "redit_cart" {
#   source_security_group_id = module.cart.sg_id
#   type                     = "ingress"
#   from_port                = 6379
#   to_port                  = 6379
#   protocol                 = "tcp"
#   security_group_id        = module.redis.sg_id
# }

# #Mysql

# #Mysql accepting connections from shipping instance
# resource "aws_security_group_rule" "mysql_shipping" {
#   source_security_group_id = module.shipping.sg_id
#   type                     = "ingress"
#   from_port                = 3306
#   to_port                  = 3306
#   protocol                 = "tcp"
#   security_group_id        = module.mysql.sg_id
# }

# #Mysql accepting connections from raiting instance
# resource "aws_security_group_rule" "mysql_raiting" {
#   source_security_group_id = module.raiting.sg_id
#   type                     = "ingress"
#   from_port                = 3306
#   to_port                  = 3306
#   protocol                 = "tcp"
#   security_group_id        = module.mysql.sg_id
# }

# #Mysql accepting connections from vpn instance
# resource "aws_security_group_rule" "mysql_vpn" {
#   source_security_group_id = module.vpn.sg_id
#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   security_group_id        = module.mysql.sg_id
# }

# #Rabbitmq

# #Rabbitmq accepting connections from payments instance
# resource "aws_security_group_rule" "mysql_payments" {
#   source_security_group_id = module.payments.sg_id
#   type                     = "ingress"
#   from_port                = 5672
#   to_port                  = 5672
#   protocol                 = "tcp"
#   security_group_id        = module.rabbitmq.sg_id
# }

# #Rabbitmq accepting connections from vpn instance
# resource "aws_security_group_rule" "rabbitmq_vpn" {
#   source_security_group_id = module.vpn.sg_id
#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   security_group_id        = module.rabbitmq.sg_id
# }

# #catalogue

# #catalogue accepting connections from vpn instance
# resource "aws_security_group_rule" "catalogue_vpn" {
#   source_security_group_id = module.vpn.sg_id
#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   security_group_id        = module.catalogue.sg_id
# }


# #catalogue accepting connections from vpn instance
# resource "aws_security_group_rule" "catalogue_vpn_http" {
#   source_security_group_id = module.vpn.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.catalogue.sg_id
# }


# # #catalogue accepting connections from web instance
# # resource "aws_security_group_rule" "catalogue_web" {
# #   source_security_group_id = module.web.sg_id
# #   type                     = "ingress"
# #   from_port                = 8080
# #   to_port                  = 8080
# #   protocol                 = "tcp"
# #   security_group_id        = module.catalogue.sg_id
# # }


# # #catalogue accepting connections from cart instance
# # resource "aws_security_group_rule" "catalogue_cart" {
# #   source_security_group_id = module.cart.sg_id
# #   type                     = "ingress"
# #   from_port                = 8080
# #   to_port                  = 8080
# #   protocol                 = "tcp"
# #   security_group_id        = module.catalogue.sg_id
# # }


# #app_alb

# #app_alb accepting connections from vpn instance
# resource "aws_security_group_rule" "app_alb_vpn" {
#   source_security_group_id = module.vpn.sg_id
#   type                     = "ingress"
#   from_port                = 80
#   to_port                  = 80
#   protocol                 = "tcp"
#   security_group_id        = module.app_alb.sg_id
# }


# #app_alb accepting connections from web instance
# resource "aws_security_group_rule" "app_alb_web" {
#   source_security_group_id = module.web.sg_id
#   type                     = "ingress"
#   from_port                = 80
#   to_port                  = 80
#   protocol                 = "tcp"
#   security_group_id        = module.app_alb.sg_id
# }

# resource "aws_security_group_rule" "web_alb_internet" {
#   cidr_blocks = ["0.0.0.0/0"]
#   type                     = "ingress"
#   from_port                = 443
#   to_port                  = 443
#   protocol                 = "tcp"
#   security_group_id        = module.web_alb.sg_id
# }

# #user

# #user accepting connections from vpn instance
# resource "aws_security_group_rule" "user_vpn" {
#   source_security_group_id = module.vpn.sg_id
#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   security_group_id        = module.user.sg_id
# }

# #user accepting connections from app_alb instance
# resource "aws_security_group_rule" "user_app_alb" {
#   source_security_group_id = module.app_alb.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.user.sg_id
# }

# # #user accepting connections from web instance
# # resource "aws_security_group_rule" "user_web" {
# #   source_security_group_id = module.web.sg_id
# #   type                     = "ingress"
# #   from_port                = 8080
# #   to_port                  = 8080
# #   protocol                 = "tcp"
# #   security_group_id        = module.user.sg_id
# # }

# # #user accepting connections from payments instance
# # resource "aws_security_group_rule" "user_payments" {
# #   source_security_group_id = module.payments.sg_id
# #   type                     = "ingress"
# #   from_port                = 8080
# #   to_port                  = 8080
# #   protocol                 = "tcp"
# #   security_group_id        = module.user.sg_id
# # }

# #Cart

# #Cart accepting connections from vpn instance
# resource "aws_security_group_rule" "cart_vpn" {
#   source_security_group_id = module.vpn.sg_id
#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   security_group_id        = module.cart.sg_id
# }

# #Cart accepting connections from web instance
# resource "aws_security_group_rule" "cart_web" {
#   source_security_group_id = module.web.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.cart.sg_id
# }

# #Cart accepting connections from web instance
# resource "aws_security_group_rule" "cart_shipping" {
#   source_security_group_id = module.shipping.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.cart.sg_id
# }

# #Cart accepting connections from payments instance
# resource "aws_security_group_rule" "cart_payments" {
#   source_security_group_id = module.payments.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.cart.sg_id
# }

# #Shipping

# #Shipping accepting connections from vpn instance
# resource "aws_security_group_rule" "shipping_vpn" {
#   source_security_group_id = module.vpn.sg_id
#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   security_group_id        = module.shipping.sg_id
# }

# #Shipping accepting connections from web instance
# resource "aws_security_group_rule" "shipping_web" {
#   source_security_group_id = module.web.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.shipping.sg_id
# }

# #payments

# #payments accepting connections from vpn instance
# resource "aws_security_group_rule" "payments_vpn" {
#   source_security_group_id = module.vpn.sg_id
#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   security_group_id        = module.payments.sg_id
# }

# #payments accepting connections from web instance
# resource "aws_security_group_rule" "payments_web" {
#   source_security_group_id = module.web.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.payments.sg_id
# }

# #web

# #web accepting connections from vpn instance
# resource "aws_security_group_rule" "web_vpn" {
#   source_security_group_id = module.vpn.sg_id
#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   security_group_id        = module.web.sg_id
# }

# #web accepting connections from internet instance
# resource "aws_security_group_rule" "web_internet" {
#   cidr_blocks       = ["0.0.0.0/0"]
#   type              = "ingress"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   security_group_id = module.web.sg_id
# }


# App ALB should accept connections only from VPN, since it is internal
resource "aws_security_group_rule" "app_alb_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}

resource "aws_security_group_rule" "app_alb_web" {
  source_security_group_id = module.web.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}

resource "aws_security_group_rule" "app_alb_cart" {
  source_security_group_id = module.cart.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}

resource "aws_security_group_rule" "app_alb_shipping" {
  source_security_group_id = module.shipping.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}

resource "aws_security_group_rule" "app_alb_user" {
  source_security_group_id = module.user.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}

resource "aws_security_group_rule" "app_alb_catalogue" {
  source_security_group_id = module.catalogue.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}

resource "aws_security_group_rule" "app_alb_payments" {
  source_security_group_id = module.payments.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}



resource "aws_security_group_rule" "web_alb_internet" {
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = module.web_alb.sg_id
}

#openvpn
resource "aws_security_group_rule" "vpn_home" {
  security_group_id = module.vpn.sg_id
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"] #ideally your home public IP address, but it frequently changes
}


resource "aws_security_group_rule" "mongodb_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.mongodb.sg_id
}

#mongodb accepting connections from catalogue instance
resource "aws_security_group_rule" "mongodb_catalogue" {
  source_security_group_id = module.catalogue.sg_id
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  security_group_id        = module.mongodb.sg_id
}

resource "aws_security_group_rule" "mongodb_user" {
  source_security_group_id = module.user.sg_id
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  security_group_id        = module.mongodb.sg_id
}

resource "aws_security_group_rule" "redis_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.redis.sg_id
}

resource "aws_security_group_rule" "redis_user" {
  source_security_group_id = module.user.sg_id
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = module.redis.sg_id
}

resource "aws_security_group_rule" "redis_cart" {
  source_security_group_id = module.cart.sg_id
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = module.redis.sg_id
}


resource "aws_security_group_rule" "mysql_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.mysql.sg_id
}

resource "aws_security_group_rule" "mysql_shipping" {
  source_security_group_id = module.shipping.sg_id
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = module.mysql.sg_id
}


resource "aws_security_group_rule" "rabbitmq_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.rabbitmq.sg_id
}

resource "aws_security_group_rule" "rabbitmq_payments" {
  source_security_group_id = module.payments.sg_id
  type                     = "ingress"
  from_port                = 5672
  to_port                  = 5672
  protocol                 = "tcp"
  security_group_id        = module.rabbitmq.sg_id
}

resource "aws_security_group_rule" "catalogue_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.catalogue.sg_id
}

resource "aws_security_group_rule" "catalogue_vpn_http" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.catalogue.sg_id
}

# resource "aws_security_group_rule" "catalogue_web" {
#   source_security_group_id = module.web.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.catalogue.sg_id
# }

resource "aws_security_group_rule" "catalogue_app_alb" {
  source_security_group_id = module.app_alb.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.catalogue.sg_id
}

# resource "aws_security_group_rule" "catalogue_cart" {
#   source_security_group_id = module.cart.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.catalogue.sg_id
# }

resource "aws_security_group_rule" "user_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.user.sg_id
}

resource "aws_security_group_rule" "user_app_alb" {
  source_security_group_id = module.app_alb.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.user.sg_id
}

# resource "aws_security_group_rule" "user_web" {
#   source_security_group_id = module.web.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.user.sg_id
# }

# resource "aws_security_group_rule" "user_payments" {
#   source_security_group_id = module.payments.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.user.sg_id
# }

resource "aws_security_group_rule" "cart_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}

# resource "aws_security_group_rule" "cart_web" {
#   source_security_group_id = module.web.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.cart.sg_id
# }

resource "aws_security_group_rule" "cart_app_alb" {
  source_security_group_id = module.app_alb.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "cart_shipping" {
  source_security_group_id = module.shipping.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "cart_payments" {
  source_security_group_id = module.payments.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "shipping_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.shipping.sg_id
}

# resource "aws_security_group_rule" "shipping_web" {
#   source_security_group_id = module.web.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.shipping.sg_id
# }

resource "aws_security_group_rule" "shipping_app_alb" {
  source_security_group_id = module.app_alb.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.shipping.sg_id
}

resource "aws_security_group_rule" "payments_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.payments.sg_id
}

# resource "aws_security_group_rule" "payments_web" {
#   source_security_group_id = module.web.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.payments.sg_id
# }

resource "aws_security_group_rule" "payment_app_alb" {
  source_security_group_id = module.app_alb.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.payments.sg_id
}

resource "aws_security_group_rule" "web_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.web.sg_id
}

resource "aws_security_group_rule" "web_internet" {
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = module.web.sg_id
}