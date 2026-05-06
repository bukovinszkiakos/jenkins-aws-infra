variable "region" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "ecr_repository_name" {
  type = string
}

variable "security_group_name" {
  type = string
}

variable "security_group_description" {
  type = string
}

variable "jenkins_server_name" {
  type = string
}

variable "app_server_name" {
  type = string
}

variable "ingress_ports" {
  type = list(number)
}

variable "scan_on_push" {
  type = bool
}

variable "image_tag_mutability" {
  type = string
}

variable "iam_role_name" {
  type = string
}

variable "iam_instance_profile_name" {
  type = string
}

variable "ecr_readonly_policy_arn" {
  type = string
}