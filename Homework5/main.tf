provider "aws" {
  region = var.region

}

resource "aws_vpc" "kaizen" {
  cidr_block           = var.vpc_info[0].vpc_cidr
  enable_dns_support   = var.vpc_info[0].dns_sup
  enable_dns_hostnames = var.vpc_info[0].dns_host


}

resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.kaizen.id
  cidr_block              = var.subnet_cidr[0].cidr
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_cidr[0].sub_name
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.kaizen.id
  cidr_block              = var.subnet_cidr[1].cidr
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_cidr[1].sub_name
  }
}

# Private subnets
resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.kaizen.id
  cidr_block        = var.subnet_cidr[2].cidr
  availability_zone = "${var.region}c"

  tags = {
    Name = var.subnet_cidr[2].sub_name
  }
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.kaizen.id
  cidr_block        = var.subnet_cidr[3].cidr
  availability_zone = "${var.region}d"

  tags = {
    Name = var.subnet_cidr[3].sub_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.kaizen.id

  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table" "pb_rt" {
  vpc_id = aws_vpc.kaizen.id

  tags = {
    Name = var.rt_public
  }
}


resource "aws_route_table" "pr_rt" {
  vpc_id = aws_vpc.kaizen.id

  tags = {
    Name = var.rt_private
  }
}

resource "aws_route_table_association" "pb1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.pb_rt.id
}

resource "aws_route_table_association" "pb2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.pb_rt.id
}

resource "aws_route_table_association" "pr1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.pr_rt.id
}

resource "aws_route_table_association" "pr2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.pr_rt.id
}