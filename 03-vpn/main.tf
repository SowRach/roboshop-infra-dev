module "vpn" {
  source = "../../terraform_aws_instance"

  ami                    = data.aws_ami.centos8.id
  ec2_name               = "vpn"
  instance_type          = "t3.micro"
  environment            = var.environment
  project_name           = var.project_name
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
  subnet_id              =  data.aws_subnet.selected.id
  user_data              = file("openvpn.sh")
  tags = merge(
    var.common_tags,
    {
      Component = "vpn"
    },
    {
      Name = "${local.ec2_name}-vpn"
    }
  )
}  