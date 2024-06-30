# ec2 creation 

resource "aws_instance" "test-web-server" {
  ami           = "ami-0c4596ce1e7ae3e68" 
  instance_type = "t2.micro"
  subnet_id   = aws_subnet.test-web-sub.id
  key_name = "key"
  security_groups = aws_security_group.test-web-sg.id
  user_data = 