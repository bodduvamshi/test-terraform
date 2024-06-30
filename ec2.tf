
# ec2 creation 

resource "aws_instance" "test-web-server" {
  ami           = "ami-0c4596ce1e7ae3e68" 
  instance_type = "t2.micro"
  subnet_id   = aws_subnet.test-web-sub.id
  key_name = "key"
  svpc_security_group_ids = [aws_security_group.test-web-sg.id]
 #ebs_block_device = 
  user_data = file("setup.sh")
    tags = {
    Name = "test-web-server"
    }
}