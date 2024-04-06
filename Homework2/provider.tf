provider  aws {
    region = "us-east-1"
  
}

resource "aws_key_pair" "deployer" {
  key_name   = "Bastion-key"
  public_key = file("~/.ssh/id_rsa.pub")
}


resource "aws_s3_bucket" "example" {
  bucket = "kaizen-elena"

}

resource "aws_s3_bucket" "example2" {
  bucket_prefix  = "kaizen-"                         
  

}

resource "aws_s3_bucket" "example3" {
  bucket  = "adsemu-mirdaus" 
}


resource "aws_s3_bucket" "example4" {
  bucket  = "adsemu-umar"
}


resource "aws_iam_user" "lb" {
  for_each = toset([
    "jenny",
    "rose",
    "lisa",
    "jisoo"
    ])  
  name = each.key
}


