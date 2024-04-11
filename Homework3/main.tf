provider aws {
    region = "us-east-2"
}
variable "availability_zones" {
  default = ["us-east-2a", "us-east-2b", "us-east-2c",]
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

resource "aws_instance" "web" {
  ami           = data.aws_ami.amzn2.id
  instance_type = "t2.micro"
  count         = length(var.availability_zones)
  availability_zone = var.availability_zones[count.index]
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  key_name = aws_key_pair.deployer.key_name
  user_data = file("apache.sh")
  user_data_replace_on_change = true

  
  tags = {
    Name = "web-${count.index + 1}"
  }
}

