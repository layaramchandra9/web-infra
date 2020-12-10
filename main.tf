terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

# EC2 security group
resource "aws_security_group" "webapp-sg" {
  name   = "webapp-sg"
  vpc_id = var.vpc_id

  # Allow ssh and standard http/https ports inbound
  dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # # Allow only web access over http
  # ingress {
  #   description = "ingress"
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  # Access to Internet for instance
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "egress"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  tags = {
    "Name" = "webapp-sg"
  }

}

# Jenkins-Server
resource "aws_instance" "app-server" {
  ami             = var.ami
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.webapp-sg.name}"]

  key_name = "devsecops"

  user_data = file("user-data.sh")

  tags = {
    "Name" = "App-Server"
  }
}