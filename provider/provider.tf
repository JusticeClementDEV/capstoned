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