terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Main VPC"
  }
}

# Create a Subnet
resource "aws_subnet" "main_sn" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main Subnet"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "main_ig" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "Main IG"
  }
}

# Create a Route Table
resource "aws_default_route_table" "main_vpc_default_rt" {
  default_route_table_id = aws_vpc.main_vpc.default_route_table_id

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.main_ig.id
  }

  tags = {
    Name = "Main VPC Default Route Table"
  }
}

# Create a Security Group
resource "aws_security_group" "main_sg" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Default Security Group"
  }
}

# Create an EC2
resource "aws_instance" "main_ec2" {
  ami                         = "ami-041feb57c611358bd"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.main_sg.id]
  subnet_id                   = aws_subnet.main_sn.id
  associate_public_ip_address = true
  key_name                    = "production_ssh_key"

  tags = {
    Name = "Main EC2"
  }
}
