variable "region" {
  type = string
}

variable "key_name" {
    type = string
  
}

variable "ports" {
    type = list(number)
    }
  

variable "availability_zone" {
  type = list(string)
}

variable "instance_type" {
    type = string 
  
}

variable "aws_ami" {
    type = string
  
}

variable "count_ins" {
  type = string
  default = 1
}