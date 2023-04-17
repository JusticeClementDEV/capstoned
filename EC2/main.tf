terraform {
  required_providers {
    aws = {
      # version = "~>3.0"
      # source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = var.profile
  region = var.region
}


resource "aws_key_pair" "public_key" {
  key_name   = var.key_name
  public_key = file("${path.module}/public_key")
}

resource "aws_instance" "capstone" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.public_key.key_name
  security_groups = ["${aws_security_group.webserver_SG.id}"]
  user_data       = file("startup.sh")
  subnet_id       = aws_subnet.webserver_subnet.id
  tags = var.tags
  #tags = {
  #  Name = "webserverVM"
  #}

}


