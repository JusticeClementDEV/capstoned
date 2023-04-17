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

resource "aws_vpc" "capstone" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = var.tags
}


resource "aws_subnet" "webserver_subnet" {
  vpc_id            = aws_vpc.webserver_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.webserver_vpc.cidr_block, 3, 1)
  availability_zone = var.availability_zones

  tags = var.subnet_tags
}

locals {
  ports_in  = var.local_ports_in
  ports_out = var.local_ports_out
}

resource "aws_security_group" "webserver_SG" {
  name        = var.SG_name
  description = var.SG_desc
  vpc_id      = aws_vpc.webserver_vpc.id


  dynamic "ingress" {
    for_each = toset(local.ports_in)
    content {
      description = "TLS from VPC"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.egress_cidr
    }
  }
  dynamic "egress" {
    for_each = toset(local.ports_out)
    content {
      description = "TLS from VPC"
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "-1"
      cidr_blocks = var.egress_cidr
    }
  }

  tags = var.egress_tags
}

resource "aws_eip" "webserver_eip" {
  instance = aws_instance.webserver.id
  vpc      = true
}

resource "aws_internet_gateway" "webserver_gw" {
  vpc_id = aws_vpc.webserver_vpc.id

  tags = var.IGW_tags
}

resource "aws_route_table" "webserver_RTB" {
  vpc_id = aws_vpc.webserver_vpc.id

  route {
    cidr_block =  var.RTB_routes
    gateway_id = aws_internet_gateway.webserver_gw.id
  }


  tags = var.RTB_tags
}


resource "aws_route_table_association" "webserver_RTB_AS" {
  subnet_id      = aws_subnet.webserver_subnet.id
  route_table_id = aws_route_table.webserver_RTB.id

}

locals {
  public_subnet_ids = aws_subnet.webserver_subnet.*.id
  #public_subnet_ids_2 = aws_subnet.webserver_subnet.1.id
}

resource "aws_lb" "websever_lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = var.lb_type
  security_groups    = [aws_security_group.webserver_SG.id]
  enable_deletion_protection = true
  subnet_mapping {
    subnet_id = var.subnet_mapping_one
  }

  subnet_mapping {
    subnet_id =  var.subnet_mapping_two
  }

  #access_logs {
  #  bucket  = aws_s3_bucket.webserver_s3.id
  #  prefix  = "test-lb"
  #  enabled = true
  #}

  tags = var.lb_tags
}
resource "aws_s3_bucket" "webserver_s3" {
  bucket = "obustest"

  tags = var.s3_tags
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.webserver_s3.id
  acl    = var.s3_bucket_acl
}
#resource "aws_lb_listener" "front_end" {
#  load_balancer_arn = aws_lb.websever_lb.id
#  port              = "443"
#  protocol          = "HTTP"
#  ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = aws_acm_certificate.cert.arn

#  default_action {
#    type             = "forward"
#    target_group_arn = aws_lb_target_group.webserver_TG.arn
#  }
#}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.websever_lb.id
  port              = var.aws_lb_listener_port
  protocol          = var.aws_lb_listener_protocol

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.webserver_TG.arn
    # fixed_response {
    #  content_type = "text/plain"
    #  message_body = "Fixed response content"
    #  status_code  = "200"
    }
  }


#resource "aws_lb_listener_certificate" "example" {
#  listener_arn    = aws_lb_listener.front_end.arn
#  certificate_arn = aws_acm_certificate.cert.arn
#}

#resource "aws_acm_certificate" "cert" {
#  domain_name       = "example.com"
#  validation_method = "DNS"

#  tags = {
#    Environment = "test"
#  }

#  lifecycle {
#    create_before_destroy = true
#  }
#}

resource "aws_lb_target_group" "webserver_TG" {
  name     = var.aws_lb_TG_name
  port     = var.aws_lb_TG_port
  protocol = var.aws_lb_TG_protocol
  vpc_id   = aws_vpc.webserver_vpc.id
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.webserver_TG.arn
  target_id        = aws_instance.webserver.id
  port             = var.aws_lb_TG_port
}

resource "aws_lb_listener_rule" "redirect_http_to_https" {
  listener_arn = aws_lb_listener.front_end.arn

  action {
    type = var.aws_lb_rule_action

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    http_header {
      http_header_name = "X-Forwarded-For"
      values           = ["172.16.8.*"]
    }
  }
}


