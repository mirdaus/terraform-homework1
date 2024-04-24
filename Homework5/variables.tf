variable "region" {
  type = string
}

variable "vpc_info" {
  type = list(object({
    vpc_cidr = string
    dns_host = bool
    dns_sup  = bool
  }))
}

variable "igw_name" {
  type = string
}


variable "subnet_cidr" {
  type = list(object({
    cidr     = string
    sub_name = string
  }))

}

variable "rt_public" {
  type = string
}

variable "rt_private" {
  type = string
}

variable "ec2_cidr" {
  type = list(object({
    ec2_name = string
    ec2_type = string
  }))

}

variable "ports" {
  type = list(string)
}