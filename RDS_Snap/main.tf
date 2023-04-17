terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.9"
    }
  }
}

provider "aws" {
  profile = "reelcruit"
  region = "us-east-1"

}

resource "aws_vpc" "reelcruit_vpc" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "reelcruit-temp-vpc"
  }
}


resource "aws_subnet" "reelcruit_subnet" {
  vpc_id            = aws_vpc.reelcruit_vpc.id
  cidr_block        = "172.16.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "reelcruit-subnets"
  }
}

locals {
  ports_in  = [22, 80, 3000, 8080, 443]
  ports_out = [0]
}
resource "aws_security_group" "reelcruit_SG" {
  name        = "webservers_SG"
  description = "Allows defined inbound traffic for this webservers"
  vpc_id      = aws_vpc.reelcruit_vpc.id


  dynamic "ingress" {
    for_each = toset(local.ports_in)
    content {
      description = "TLS from VPC"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  dynamic "egress" {
    for_each = toset(local.ports_out)
    content {
      description = "TLS from VPC"
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = "allow_traffic"
  }
}
resource "aws_db_instance" "capstone" {
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.db_instance_class
  name                 = var.db_instance_name
  username             = var.username
  password             = var.password
  allocated_storage    = 20
  storage_type         = var.storage_type
  backup_retention_period = 7
  final_snapshot_identifier = var.snapshot_ID
  #vpc_security_group_ids = ["aws_security_group.reelcruit_SG"]
  #subnet_ids = data.aws_subnet_ids.reelcruit-vpc-subnets.ids
}
