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

#internet gateway creation

resource "aws_internet_gateway" "test-ig" {
  vpc_id = aws_vpc.test-vpc.id

  tags = {
    Name = "test-internet-gateway"
  }
}

#Public route tables creation

resource "aws_route_table" "test-pub-rt" {
  vpc_id = aws_vpc.test-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-ig.id
  }

  tags = {
    Name = "public-route-tables"
  }
}

#private route tables creation

resource "aws_route_table" "test-pri-rt" {
  vpc_id = aws_vpc.test-vpc.id

  tags = {
    Name = "private-route-tables"
  }
}


# route table assosiation to web subnet

resource "aws_route_table_association" "test-web-rt-asc" {
  subnet_id      = aws_subnet.test-web-sub.id
  route_table_id = aws_route_table.test-pub-rt.id
}

# route table assosiation to api subnet

resource "aws_route_table_association" "test-api-rt-asc" {
  subnet_id      = aws_subnet.test-api-sub.id
  route_table_id = aws_route_table.test-pub-rt.id
}

# route table assosiation to db subnet

resource "aws_route_table_association" "test-db-rt-asc" {
  subnet_id      = aws_subnet.test-db-sub.id
  route_table_id = aws_route_table.test-pri-rt.id
}





