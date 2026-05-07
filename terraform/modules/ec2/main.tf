resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type

  availability_zone = var.availability_zone

  vpc_security_group_ids = [var.security_group_id]

  iam_instance_profile = var.iam_instance_profile

  key_name = var.key_name

  user_data = var.user_data

  tags = {
    Name = var.name
  }
}