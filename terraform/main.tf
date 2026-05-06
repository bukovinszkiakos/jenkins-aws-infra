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

  user_data = file("${path.module}/user_data/jenkins.sh")
}

module "app_ec2" {
  source = "./modules/ec2"

  name              = var.app_server_name
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  security_group_id = module.security_group.security_group_id
  key_name          = var.key_name

  user_data = file("${path.module}/user_data/app.sh")
}