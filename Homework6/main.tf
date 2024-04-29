provider "aws" {
  region = var.region

}

variable "region" {
  default = ""
  type    = string
}

terraform {
  backend "s3" {
    bucket         = "elena-kaizen"
    key            = "ohio/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "state-lock"

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

  owners = ["099720109477"]
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