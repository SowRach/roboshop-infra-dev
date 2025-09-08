resource "aws_lb_target_group" "web" {
  name     = "${local.name}-${var.tags.Component}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_ssm_parameter.vpc_id.value
  deregistration_delay = 60
  health_check {
      healthy_threshold   = 2
      interval            = 10
      unhealthy_threshold = 3
      timeout             = 5
      path                = "/health"
      port                = 80
      matcher = "200-299"
  }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.centos8.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.web_sg_id.value]
  subnet_id              = element(split(",", data.aws_ssm_parameter.private_subnet_ids.value), 0)
  iam_instance_profile   = "ShellScriptRoleForRoboshop"
  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-web"
    }
  )
}

resource "terraform_data" "web" {
  triggers_replace = [
    aws_instance.web.id
  ]

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = aws_instance.web.private_ip
    type = "ssh"
    user = "centos"
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
      "sudo sh /tmp/bootstrap.sh web dev"
    ]
  }
}

resource "aws_ec2_instance_state" "web" {
  instance_id = aws_instance.web.id
  state       = "stopped"
  depends_on = [ terraform_data.web ]
}

resource "aws_ami_from_instance" "web" {
  name               = "${local.name}-${var.tags.Component}-${local.current_time}"
  source_instance_id = aws_instance.web.id
  depends_on = [ aws_ec2_instance_state.web ]

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-web"
    }
  )
}

resource "terraform_data" "web_delete" {
  triggers_replace = [
    aws_instance.web.id
  ]

  provisioner "local-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    command = "aws ec2 terminate-instances --instance-ids ${aws_instance.web.id} --region ${var.aws_region}"
  }

  depends_on = [ aws_ami_from_instance.web]
}

resource "aws_launch_template" "web" {
  name = "${local.name}-${var.tags.Component}"

  image_id = aws_ami_from_instance.web.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t2.micro"
  update_default_version = true

  vpc_security_group_ids = [data.aws_ssm_parameter.web_sg_id.value]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${local.name}-${var.tags.Component}"
    }
  }

}

resource "aws_autoscaling_group" "web" {
  name                      = "${local.name}-${var.tags.Component}"
  max_size                  = 10
  min_size                  = 1
  health_check_grace_period = 60
  health_check_type         = "ELB"
  desired_capacity          = 2
  vpc_zone_identifier       = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
  target_group_arns = [ aws_lb_target_group.web.arn ]
  
  launch_template {
    id      = aws_launch_template.web.id
    version = aws_launch_template.web.latest_version
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["launch_template"]
  }

  tag {
    key                 = "Name"
    value               = "${local.name}-${var.tags.Component}"
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }
}

resource "aws_lb_listener_rule" "web" {
  listener_arn = data.aws_ssm_parameter.web_alb_listener_arn.value
  priority     = 20

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }


  condition {
    host_header {
      values = ["${var.tags.Component}-${var.environment}.${var.zone_name}"]
    }
  }
}

resource "aws_autoscaling_policy" "web" {
  autoscaling_group_name = aws_autoscaling_group.web.name
  name                   = "${local.name}-${var.tags.Component}"
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 5.0
  }
}