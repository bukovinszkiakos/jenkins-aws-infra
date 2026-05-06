region = "eu-central-1"

ami_id = "ami-0faab6bdbac9486fb"

instance_type = "t3.medium"

key_name = "jenkins-demo-key"

ecr_repository_name = "akos-jenkins-demo-app"

security_group_name = "akos-jenkins-demo-sg"

security_group_description = "Security group for Jenkins demo"

jenkins_server_name = "akos-jenkins-server"

app_server_name = "akos-app-server"

ingress_ports = [22, 8080, 3000]

scan_on_push = true

image_tag_mutability = "MUTABLE"

iam_role_name             = "ec2-ecr-role"
iam_instance_profile_name = "ec2-profile"

ecr_readonly_policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"