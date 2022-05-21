# Create a Security group to allow Ports ( 443 , 22 , 80 ) 
resource "aws_security_group" "sec_group" {
  name        = "allow_ports"
  description = "Allow some ports to our webserver "
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "HTTPS FROM VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.vpc.cidr_block]
  }
  ingress {
    description      = "HTTP FROM VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.vpc.cidr_block]
  }
  ingress {
    description      = "SSH FROM VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.vpc.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}

