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


resource "aws_instance" "web1" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.ec2_crdt[0].instance_type
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data              = file("apache.sh")
  subnet_id = aws_subnet.pb1.id

  tags = {
    Name = var.ec2_crdt[0].instance_name
  }

}


data "aws_ami" "amzn2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20240329.0-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}


resource "aws_instance" "web2" {
  ami                    = data.aws_ami.amzn2.id
  instance_type          = var.ec2_crdt[1].instance_type
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data              = file("httpd.sh")
  subnet_id = aws_subnet.pb2.id


  tags = {
    Name = var.ec2_crdt[1].instance_name
  }
}