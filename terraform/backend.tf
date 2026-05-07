
terraform {
  backend "s3" {
    bucket = "akos-terraform-state-123"
    key    = "jenkins-demo/terraform.tfstate"
    region = "eu-central-1"
  }
}