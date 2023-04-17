terraform {
  required_providers {
    aws = {
      version = "~>3.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "eu-west-3"
}

data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_subnet_ids" "default_subnet" {
  vpc_id = data.aws_vpc.default_vpc.id
}

resource "aws_security_group" "instances" {
  name = "devcha-terraform-sg"
}

resource "aws_db_instance" "db_instance" {
  allocated_storage = 20
  auto_minor_version_upgrade = true
  storage_type               = "standard"
  engine                     = "postgres"
  engine_version             = "12"
  instance_class             = "db.t3.micro"
  name                       = "RDS_DB"
  username                   = "postgres"
  password                   = "AlexandreRuiAurthur"
  skip_final_snapshot        = true
}