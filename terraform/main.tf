module "ecr" {
  source = "./modules/ecr"

  repository_name      = var.ecr_repository_name
  scan_on_push         = var.scan_on_push
  image_tag_mutability = var.image_tag_mutability
}

module "security_group" {
  source = "./modules/security-group"

  name        = var.security_group_name
  description = var.security_group_description

  ingress_ports = var.ingress_ports
}



module "jenkins_ec2" {
  source = "./modules/ec2"

  name              = var.jenkins_server_name
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  security_group_id = module.security_group.security_group_id
  key_name          = var.key_name

  availability_zone = "eu-central-1a"

  user_data = file("${path.module}/user_data/jenkins.sh")
}

module "app_ec2" {
  source = "./modules/ec2"

  name              = var.app_server_name
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  security_group_id = module.security_group.security_group_id
  key_name          = var.key_name

  iam_instance_profile = module.iam.instance_profile_name

  user_data = file("${path.module}/user_data/app.sh")
}

module "iam" {
  source = "./modules/iam"

  role_name             = var.iam_role_name
  instance_profile_name = var.iam_instance_profile_name
  policy_arn            = var.ecr_readonly_policy_arn
}


##module "jenkins_ebs" {
##  source = "./modules/ebs"

##  availability_zone = module.jenkins_ec2.availability_zone
##  size              = 10
##  name              = "jenkins-data"
##}



resource "aws_volume_attachment" "jenkins_data" {
  device_name = "/dev/sdf"

  volume_id   = "vol-0968a680192e98171"

  instance_id = module.jenkins_ec2.instance_id
}


data "aws_eip" "existing_app_ip" {
  public_ip = "3.74.64.15"
}


resource "aws_eip_association" "app_ip_assoc" {
  instance_id   = module.app_ec2.instance_id

  allocation_id = data.aws_eip.existing_app_ip.id
}