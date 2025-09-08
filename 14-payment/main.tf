resource "aws_lb_target_group" "payments" {
  name                 = "${var.project_name}-${var.environment}-payments" #roboshop-dev-payments
  port                 = 8080
  protocol             = "HTTP"
  vpc_id               = data.aws_ssm_parameter.vpc_id.value
  deregistration_delay = 120
  health_check {
    healthy_threshold   = 2
    interval            = 5
    matcher             = "200-299"
    path                = "/health"
    port                = 8080
    timeout             = 2
    unhealthy_threshold = 3
  }
}

resource "aws_instance" "payments" {
  ami                    = data.aws_ami.centos8.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.payments_sg_id.value]
  subnet_id              = local.private_subnet_id
  iam_instance_profile   = var.iam_instance_profile
  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-payments"
    }
  )
}

resource "terraform_data" "payments" {
  triggers_replace = [
    aws_instance.payments.id
  ]

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host     = aws_instance.payments.private_ip
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
      "sudo sh /tmp/bootstrap.sh payment dev"
    ]
  }
}

resource "aws_ec2_instance_state" "payments" {
  instance_id = aws_instance.payments.id
  state       = "stopped"
  depends_on  = [terraform_data.payments]
}


resource "aws_ami_from_instance" "payments" {
  name               = "${local.name}-${var.tags.Component}-${local.current_time}"
  source_instance_id = aws_instance.payments.id
  depends_on         = [aws_ec2_instance_state.payments]
  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-payments"
    }
  )
}

resource "terraform_data" "payments_delete" {
  triggers_replace = [
    aws_instance.payments.id
  ]

  # make sure you have aws configure in your laptop
  provisioner "local-exec" {
    command = "aws ec2 terminate-instances --instance-ids ${aws_instance.payments.id} --region ${var.aws_region}"
  }

  depends_on = [aws_ami_from_instance.payments]
}

#LaunchTemplate

resource "aws_launch_template" "payments" {
  name                                 = "${var.project_name}-${var.environment}-payments"
  image_id                             = aws_ami_from_instance.payments.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = "t3.micro"
  vpc_security_group_ids               = [data.aws_ssm_parameter.payments_sg_id.value]
  update_default_version               = true # each time you update, new version will become default
  tag_specifications {
    resource_type = "instance"
    # EC2 tags created by ASG
    tags = merge(
      var.common_tags,
      {
        Name = "${var.project_name}-${var.environment}-payments"
      }
    )
  }
}

#AutoScaling

resource "aws_autoscaling_group" "payments" {
  name                      = "${var.project_name}-${var.environment}-payments"
  desired_capacity          = 1
  max_size                  = 10
  min_size                  = 1
  target_group_arns         = [aws_lb_target_group.payments.arn]
  vpc_zone_identifier       = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
  health_check_grace_period = 90
  health_check_type         = "ELB"

  launch_template {
    id      = aws_launch_template.payments.id
    version = aws_launch_template.payments.latest_version
  }

  dynamic "tag" {
    for_each = merge(
      var.common_tags,
      {
        Name = "${var.project_name}-${var.environment}-payments"
      }
    )
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }

  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["launch_template"]
  }

  timeouts {
    delete = "15m"
  }
}

resource "aws_lb_listener_rule" "payments" {
  listener_arn = data.aws_ssm_parameter.app_alb_listener_arn.value
  priority     = 60
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.payments.arn
  }


  condition {
    host_header {
      values = ["${var.tags.Component}.app-${var.environment}.${var.zone_name}"]
    }
  }
}

resource "aws_autoscaling_policy" "payments" {
  autoscaling_group_name = aws_autoscaling_group.payments.name
  name                   = "${var.project_name}-${var.environment}-${var.tags.Component}"
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 5.0
  }
}