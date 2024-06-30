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


# NACL web creataion

resource "aws_network_acl" "test-web-nacl" {
  vpc_id = aws_vpc.test-vpc.id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "test-web-nacl"
  }
}

#NACL api creataion

resource "aws_network_acl" "test-api-nacl" {
  vpc_id = aws_vpc.test-vpc.id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "test-api-nacl"
  }
}


#NACL db creataion

resource "aws_network_acl" "test-db-nacl" {
  vpc_id = aws_vpc.test-vpc.id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "test-db-nacl"
  }
}



# nacl and subnet web assosiation

resource "aws_network_acl_association" "test-nacl-sub-web-asc" {
  network_acl_id = aws_network_acl.test-web-nacl.id
  subnet_id      = aws_subnet.test-web-sub.id
}

# nacl and subnet api assosiation

resource "aws_network_acl_association" "test-nacl-sub-api-asc" {
  network_acl_id = aws_network_acl.test-api-nacl.id
  subnet_id      = aws_subnet.test-api-sub.id
}

# nacl and subnet db assosiation

resource "aws_network_acl_association" "test-nacl-sub-db-asc" {
  network_acl_id = aws_network_acl.test-db-nacl.id
  subnet_id      = aws_subnet.test-db-sub.id
}

# web security group creation 

resource "aws_security_group" "test-web-sg" {
  name        = "test-web-sg"
  description = "Allow ssh traffic and http traffic"
  vpc_id      = aws_vpc.test-vpc.id

  tags = {
    Name = "test-web-sg-ssh-http"
  }
}

resource "aws_vpc_security_group_ingress_rule" "test-web-sg-ingress-ssh" {
  security_group_id = aws_security_group.test-web-sg.id
  cidr_ipv4         = 0.0.0.0/0
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "test-web-sg-ingress-http" {
  security_group_id = aws_security_group.test-web-sg.id
  cidr_ipv4         = 0.0.0.0/0
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "atest-web-sg-egress" {
  security_group_id = aws_security_group.test-web-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


# api security group creation 

resource "aws_security_group" "test-api-sg" {
  name        = "test-api-sg"
  description = "Allow ssh traffic and nodejs traffic"
  vpc_id      = aws_vpc.test-vpc.id

  tags = {
    Name = "test-api-sg-ssh-nodejs"
  }
}

resource "aws_vpc_security_group_ingress_rule" "test-api-sg-ingress-ssh" {
  security_group_id = aws_security_group.test-api-sg.id
  cidr_ipv4         = 0.0.0.0/0
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "test-web-sg-ingress-nodejs" {
  security_group_id = aws_security_group.test-api-sg.id
  cidr_ipv4         = 0.0.0.0/0
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}

resource "aws_vpc_security_group_egress_rule" "atest-api-sg-egress" {
  security_group_id = aws_security_group.test-api-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}



# db security group creation 

resource "aws_security_group" "test-db-sg" {
  name        = "test-db-sg"
  description = "Allow ssh traffic and postgress traffic"
  vpc_id      = aws_vpc.test-vpc.id

  tags = {
    Name = "test-db-sg-ssh-postgress"
  }
}

resource "aws_vpc_security_group_ingress_rule" "test-db-sg-ingress-ssh" {
  security_group_id = aws_security_group.test-db-sg.id
  cidr_ipv4         = 0.0.0.0/0
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "test-web-sg-ingress-postgress" {
  security_group_id = aws_security_group.test-db-sg.id
  cidr_ipv4         = 10.0.0.0/16
  from_port         = 5432
  ip_protocol       = "tcp"
  to_port           = 5432
}

resource "aws_vpc_security_group_egress_rule" "atest-db-sg-egress" {
  security_group_id = aws_security_group.test-db-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

