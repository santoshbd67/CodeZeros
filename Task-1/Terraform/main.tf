provider "aws" {
  region = var.region
}

resource "aws_vpc" "nodejs_app_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "nodejs-app-vpc"
  }
}

resource "aws_internet_gateway" "nodejs_app_igw" {
  vpc_id = aws_vpc.nodejs_app_vpc.id

  tags = {
    Name = "nodejs-app-igw"
  }
}

resource "aws_subnet" "nodejs_app_subnet" {
  vpc_id     = aws_vpc.nodejs_app_vpc.id
  cidr_block = var.subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "nodejs-app-subnet"
  }
}

resource "aws_route_table" "nodejs_app_route_table" {
  vpc_id = aws_vpc.nodejs_app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nodejs_app_igw.id
  }

  tags = {
    Name = "nodejs-app-route-table"
  }
}

resource "aws_route_table_association" "nodejs_app_association" {
  subnet_id      = aws_subnet.nodejs_app_subnet.id
  route_table_id = aws_route_table.nodejs_app_route_table.id
}

resource "aws_security_group" "nodejs_app_sg" {
  vpc_id = aws_vpc.nodejs_app_vpc.id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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
    Name = "nodejs-app-sg"
  }
}

resource "aws_instance" "nodejs_app_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.nodejs_app_subnet.id
  key_name      = var.key_pair_name
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.nodejs_app_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y docker.io
              systemctl start docker
              systemctl enable docker
              EOF

  tags = {
    Name = "nodejs-app-instance"
  }
}
