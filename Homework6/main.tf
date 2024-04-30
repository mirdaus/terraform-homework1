provider "aws" {
  region = var.region

}

variable "region" {
  type = string

}

terraform {
  backend "s3" {
    bucket         = "elena-kaizen"      # Replace with your S3 bucket name
    key            = "terraform.tfstate" # Replace with the desired state file name
    region         = "us-east-1"         # Replace with your desired AWS region
    dynamodb_table = "state-lock"        # Replace with your DynamoDB table name for state locking
    encrypt        = true                # Enable encryption of the state file
  }
}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


variable "instance_type" {
  type = string
}


resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data              = file("apache.sh")

}