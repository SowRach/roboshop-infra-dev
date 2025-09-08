# Mongodb

module "mongodb" {
  source = "../../terraform_aws_instance"

  ami                    = data.aws_ami.centos8.id
  instance_type          = "t3.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.mongodb_sg_id.value]
  subnet_id              = local.database_subnet_id
  environment            = var.environment
  project_name           = var.project_name
  ec2_name               = "mongodb"


  tags = merge(

    {
      component = "mongodb"
    },
    {
      Name = "${local.ec2_name}-mongodb"
    }
  )

}

resource "terraform_data" "mongodb" {
  triggers_replace = [
    module.mongodb.id
  ]

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host     = module.mongodb.private_ip
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
  }

  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [

      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mongodb dev"

    ]
  }
}

# Redis

module "redis" {
  source = "../../terraform_aws_instance"

  ami                    = data.aws_ami.centos8.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.redis_sg_id.value]
  subnet_id              = local.database_subnet_id
  environment            = var.environment
  project_name           = var.project_name
  ec2_name               = "redis"


  tags = merge(

    {
      component = "redis"
    },
    {
      Name = "${local.ec2_name}-redis"
    }
  )

}

resource "terraform_data" "redis" {
  triggers_replace = [
    module.redis.id
  ]

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host     = module.redis.private_ip
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
  }

  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh redis dev"
    ]
  }
}

# Mysql

module "mysql" {
  source = "../../terraform_aws_instance"

  ami                    = data.aws_ami.centos8.id
  instance_type          = "t3.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.mysql_sg_id.value]
  subnet_id              = local.database_subnet_id
  environment            = var.environment
  project_name           = var.project_name
  ec2_name               = "mysql"
  # iam_instance_profile = "ShellScriptRoleForRoboshop"

  tags = merge(

    {
      component = "mysql"
    },
    {
      Name = "${local.ec2_name}-mysql"
    }
  )

}

resource "terraform_data" "mysql" {
  triggers_replace = [
    module.mysql.id
  ]

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host     = module.mysql.private_ip
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
  }

  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mysql dev"
    ]
  }
}

# Rabbitmq

module "rabbitmq" {
  source                 = "../../terraform_aws_instance"
  ami                    = data.aws_ami.centos8.id
  instance_type          = "t3.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.rabbitmq_sg_id.value]
  subnet_id              = local.database_subnet_id
  environment            = var.environment
  project_name           = var.project_name
  ec2_name               = "rabbitmq"
  # iam_instance_profile = "ShellScriptRoleForRoboshop"

  tags = merge(

    {
      component = "rabbitmq"
    },
    {
      Name = "${local.ec2_name}-rabbitmq"
    }
  )

}

resource "terraform_data" "rabbitmq" {
  triggers_replace = [
    module.rabbitmq.id
  ]

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host     = module.rabbitmq.private_ip
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
  }

  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh rabbitmq dev"
    ]
  }
}

# Route 53

resource "aws_route53_record" "mongodb" {
  zone_id         = var.zone_id
  name            = "mongodb-${var.environment}.${var.zone_name}"
  type            = "A"
  ttl             = 1
  records         = [module.mongodb.private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "redis" {
  zone_id         = var.zone_id
  name            = "redis-${var.environment}.${var.zone_name}"
  type            = "A"
  ttl             = 1
  records         = [module.redis.private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "mysql" {
  zone_id         = var.zone_id
  name            = "mysql-${var.environment}.${var.zone_name}"
  type            = "A"
  ttl             = 1
  records         = [module.mysql.private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "rabbitmq" {
  zone_id         = var.zone_id
  name            = "rabbitmq-${var.environment}.${var.zone_name}"
  type            = "A"
  ttl             = 1
  records         = [module.rabbitmq.private_ip]
  allow_overwrite = true
}