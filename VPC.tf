# VPCS creation

resource "aws_vpc" "test-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "test-vpc"
  }
}

#Subnet web creation

resource "aws_subnet" "test-web-sub" {
  vpc_id     = aws_vpc.test-vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "test-web-subnet"
  }
}

#Subnet app creation

resource "aws_subnet" "test-api-sub" {
  vpc_id     = aws_vpc.test-vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "test-api-subnet"
  }
}

#Subnet db creation

resource "aws_subnet" "test-db-sub" {
  vpc_id     = aws_vpc.test-vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "test-db-subnet"
  }
}



