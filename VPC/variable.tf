variable "profile" {
  type = string(any)
  default = "bulb"
}

variable "region"{
    type = string(any)
    default = "eu-central-1"
}

variable "tags"{
    type = map(string)
    default = {
        name = "bulb"
    }
}

variable "availability_zones" {
  type = string
  default ="eu-central-1a"
}

variable "subnet_tags"{
    type = map(string)
    default = {
        name = "newsubnet"
    }
}

variable "local_ports_in"{
    type = list
    default = [22,3000,80,8080,443]
}

variable "local_ports_out" {
  type = list
  default = [0]
}

variable "SG_name" {
  type = string(any)
  default = capstoneSG
}

variable "SG_desc"{
    type = string(any)
    default = "This is the security group that defines the access into the VPC and Resources that resides in it."
}

variable "egress_cidr" {
  type = list(string)
  default = ["0.0.0.0/0"]
}

variable "egress_tags" {
  type = map(string)
  default = {
     Name = "allow_traffic"
  }
}

variable "IGW_tags"{
    type = map(string)
    default = {
      Name = "webserver_gw"
    }
}

variable "RTB_routes" {
  type = string(any)
  default = "0.0.0.0/0"
}

variable "RTB_tags" {
  type = map(string)
  default = {
     Name = "webserver_RTB"
  }
}

variable "lb_name"{
    type = string(any)
    default = "capstone-loadbalancer"

}

variable "lb_type" {
  type  = string
  default = "application"
}

variable "subnet_mapping_one"{
    type = string
    default = ""
}

variable "subnet_mapping_two" {
  type = string
  default  = ""
}

variable "lb_tags"{
    type = map(string)
    default = {
       Environment = "production"
    }
}

variable "s3_name" {
  type = string
  default = "abayomi-capstone"

}

variable "s3_tags"{
    type = map(string)
    default = {
      Name        = "My bucket"
      Environment = "Dev"
    }
}

variable "s3_bucket_acl" {
  type = string(any)
  default = "public-read"
}

variable "aws_lb_listener_port"{
    type = string
    default = "80"
}
variable "aws_lb_listener_protocol"{
    type = string
    default = "HTTP"
}

variable "aws_lb_listener_protocol_default_action_type"{
    type = string
    default = "forward"
}

variable "aws_lb_TG_name"{
    type = string
    default = "tf-example-lb-tg"
}
variable "aws_lb_TG_port" {
    default = 80
}
variable "aws_lb_TG_protocol" {
    type = string
    default = "HTTP"
}

variable "aws_lb_rule_action" {
  type= string
  default = "redirect"
}
