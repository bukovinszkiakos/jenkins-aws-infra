resource "aws_ebs_volume" "this" {
  availability_zone = var.availability_zone

  size = var.size

  tags = {
    Name = var.name
  }

  lifecycle {
    prevent_destroy = true
  }
}