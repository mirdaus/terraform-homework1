# terraform-homework1
region = "us-east-2"
aws_ami = "ami-0900fe555666598a2"
instance_type = "t2.micro"
availability_zone = ["us-east-2a", "us-east-2b",  "us-east-2c" ]
ports = [ 22, 80 , 443 ]
key_name = "kaizen"