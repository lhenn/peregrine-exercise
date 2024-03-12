resource "aws_vpc_peering_connection" "prd_peering" {
  peer_vpc_id = aws_vpc.database_vpc.id
  vpc_id      = aws_vpc.web_app_vpc.id
  peer_region = "us-east-1"
  accepter {
    allow_remote_vpc_dns_resolution = true
  }
  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

### Web App VPC
resource "aws_vpc" "web_app_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "prd-peregrine-webapp"
    Env  = "Prd"
  }
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# Web App NACL
resource "aws_network_acl" "web_app_nacl" {
  vpc_id = aws_vpc.web_app_vpc.id
  # TODO: add rules
}

# Web App Security Group
resource "aws_security_group" "web_app_sg" {
  name        = "web_app_sg"
  description = "Security group for web application in VPC"
  vpc_id      = aws_vpc.web_app_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
    Name = "web_app_sg"
    Env  = "Prd"
  }
}

# Web App Subnets
resource "aws_subnet" "web_app_subnet_1a" {
  vpc_id            = aws_vpc.web_app_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "prd-peregrine-webapp-subnet-us-east-1a"
    Env  = "Prd"
  }
}

resource "aws_subnet" "web_app_subnet_1b" {
  vpc_id            = aws_vpc.web_app_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "prd-peregrine-webapp-subnet-us-east-1b"
    Env  = "Prd"
  }
}

### Database VPC
resource "aws_vpc" "database_vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "prd-peregrine-rds"
    Env  = "Prd"
  }
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# Database NACL
resource "aws_network_acl" "database_nacl" {
  vpc_id = aws_vpc.database_vpc.id
  # TODO: add rules
}

# Database security Group
resource "aws_security_group" "database_sg" {
  name        = "database_sg"
  description = "Security group for RDS database in VPC"
  vpc_id      = aws_vpc.database_vpc.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.web_app_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "database_sg"
    Env  = "Prd"
  }
}

# Database Subnets
resource "aws_subnet" "database_subnet_1a" {
  vpc_id            = aws_vpc.database_vpc.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "prd-peregrine-rds-us-east-1a"
    Env  = "Prd"
  }
}

resource "aws_subnet" "database_subnet_1b" {
  vpc_id            = aws_vpc.database_vpc.id
  cidr_block        = "10.1.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "prd-peregrine-rds-us-east-1b"
    Env  = "Prd"
  }
}
