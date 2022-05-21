# Create a VPC 
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = "My VPC"
  }
}


# Configure an Internet gateway for VPC 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Internal Gateway For VPC"
  }
}

#Create a Route Table 
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Route Table For VPC"
  }

}


#Create a public subnet inside this vpc 
resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.aws_avail_zone
  depends_on = [aws_internet_gateway.igw]

    tags = {
    Name = "Public Subnet Inside VPC "
  }

}

#Create a Private Subnet For AWS RDS MYSQL
resource "aws_subnet" "priv_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_cidr_block_private
  availability_zone = var.aws_avail_zone
  map_public_ip_on_launch = false

    tags = {
    Name = "Private Subnet Inside VPC For RDS "
  }
}

#Associate the subnet with the route table 
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.rt.id
}


#Create a DataBase Subnet Group 

resource "aws_db_subnet_group" "subnet_group" {
  subnet_ids = [aws_subnet.priv_subnet.id]
}


# Network Interface 

resource "aws_network_interface" "nci" {
  subnet_id       = aws_subnet.subnet.id
  private_ips     = [var.private_ip]
  security_groups = [aws_security_group.sec_group.id]


}

# Assign Elastic IP to the network Interface

resource "aws_eip" "eip" {
  vpc                       = true
  network_interface         = aws_internet_gateway.igw.id
  associate_with_private_ip = var.private_ip

    depends_on = [aws_internet_gateway.igw]

}


