variable "region" {
  type = string
}

variable "vpc_dns" {
  type = list(object({
    vpc_cidr = string
    dns_sup  = bool
    dns_host = bool
  }))
}

variable "igw_name" {
  type = string
}


variable "subnet_crdt" {
  type = list(object({
    cidr= string
    subnet_name = string
  }))
  
}

variable "rt_public" {
  type = string
}

variable "rt_private" {
  type = string
}

variable "ec2_crdt" {
  type = list(object({
    instance_type = string
    instance_name = string
  }))
  
}

variable "ports" {
  type = list(string)
}