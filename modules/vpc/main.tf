# Create a VPC
resource "aws_vpc" "web-vpc" {
  cidr_block       = var.web_vpc_cidr
  instance_tenancy = var.web_vpc_tenancy
  enable_dns_hostnames = true 
  enable_dns_support = true

  tags = {
    Name = "web-vpc"
  }
}
# Create Public Subnet 1
resource "aws_subnet" "Public-Subnet-1" {
  vpc_id     = aws_vpc.web-vpc.id
  cidr_block = var.public_sid1
  availability_zone = var.az1

  tags = {
    Name = var.public_sid1_name
  }
}

# Create Private Subnet 1
resource "aws_subnet" "Private-Subnet-1" {
  vpc_id     = aws_vpc.web-vpc.id
  cidr_block = var.private_sid1
  availability_zone = var.az1

  tags = {
    Name = var.private_sid1_name
  }
}

# Create Public Subnet 2
resource "aws_subnet" "Public-Subnet-2" {
  vpc_id     = aws_vpc.web-vpc.id
  cidr_block = var.public_sid2
  availability_zone = var.az2

  tags = {
    Name = var.public_sid2_name
  }
}



# Create Private Subnet 2
resource "aws_subnet" "Private-Subnet-2" {
  vpc_id     = aws_vpc.web-vpc.id
  cidr_block = var.private_sid2
  availability_zone = var.az2

  tags = {
    Name = var.private_sid2_name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "web-igw" {
  vpc_id = aws_vpc.web-vpc.id

  tags = {
    Name = "internet-gateway"
  }
}

# Elastic IP 1
resource "aws_eip" "web-eip1" {
  vpc               = true
  depends_on        = [aws_internet_gateway.web-igw]
}

# Elastic IP 2
resource "aws_eip" "web-eip2" {
  vpc               = true
  depends_on        = [aws_internet_gateway.web-igw]
}

# Nat Gateway 1
resource "aws_nat_gateway" "web-ngw1" {
  allocation_id = aws_eip.web-eip1.id
  subnet_id     = aws_subnet.Public-Subnet-1.id

  tags = {
    Name = "nat-gateway 1"
  }
}

# Nat Gateway 2
resource "aws_nat_gateway" "web-ngw2" {
  allocation_id = aws_eip.web-eip2.id
  subnet_id     = aws_subnet.Public-Subnet-2.id

  tags = {
    Name = "nat-gateway 2"
  }
}


# Public Route table 1
resource "aws_route_table" "rtb-public1" {
  vpc_id = aws_vpc.web-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.web-igw.id
  }

  tags = {
    Name = "public-route-table-1"
  }
}


# Private Route table 1
resource "aws_route_table" "rtb-private1" {
  vpc_id = aws_vpc.web-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.web-ngw1.id
  }

  tags = {
    Name = "private-route-table-1"
  }
}

# Private Route table 2
resource "aws_route_table" "rtb-private2" {
  vpc_id = aws_vpc.web-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.web-ngw2.id
  }

  tags = {
    Name = "private-route-table-2"
  }
}

# Public Route Table 1 Association with Public Subnet
resource "aws_route_table_association" "public1-rtba" {
  subnet_id      = aws_subnet.Public-Subnet-1.id
  route_table_id = aws_route_table.rtb-public1.id
}

# Public Route Table 2 Association with Public Subnet
resource "aws_route_table_association" "public2-rtba" {
  subnet_id      = aws_subnet.Public-Subnet-2.id
  route_table_id = aws_route_table.rtb-public1.id
}

# private Route Table 1 Association with private Subnet
resource "aws_route_table_association" "private1-rtba" {
  subnet_id      = aws_subnet.Private-Subnet-1.id
  route_table_id = aws_route_table.rtb-private1.id
}

# private Route Table 2 Association with private Subnet
resource "aws_route_table_association" "private2-rtba" {
  subnet_id      = aws_subnet.Private-Subnet-2.id
  route_table_id = aws_route_table.rtb-private2.id
}




