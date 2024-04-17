provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "kaizen" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "kaizen"
  }
}


resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.kaizen.id
  cidr_block = "10.0.1.0/24"  
  availability_zone = "us-west-2a"  
  map_public_ip_on_launch = true

  tags = {
    Name = "public1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.kaizen.id
  cidr_block = "10.0.2.0/24" 
  availability_zone = "us-west-2b"  
  map_public_ip_on_launch = true

  tags = {
    Name = "public2"
  }
}

resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.kaizen.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-west-2c" 
  map_public_ip_on_launch = false

  tags = {
    Name = "private1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.kaizen.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-west-2d"  
  map_public_ip_on_launch = false

  tags = {
    Name = "private2"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.kaizen.id

  tags = {
    Name = "homework5_igw"
  }
}