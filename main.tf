# VPC
resource "aws_vpc" "sysops_vpc" {
  cidr_block       = "10.99.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "SysOpsVPC"
  }
}

# Subnets

# First DMZ Layer
resource "aws_subnet" "dmz1_public" {
  vpc_id            = aws_vpc.sysops_vpc.id
  cidr_block        = "10.99.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "DMZ1public"
  }
}

# Second DMZ Layer
resource "aws_subnet" "dmz2_public" {
  vpc_id            = aws_vpc.sysops_vpc.id
  cidr_block        = "10.99.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "DMZ2public"
  }
}

# First App Layer
resource "aws_subnet" "applayer1_private" {
  vpc_id            = aws_vpc.sysops_vpc.id
  cidr_block        = "10.99.11.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "AppLayer1private"
  }
}

# Second App Layer
resource "aws_subnet" "applayer2_private" {
  vpc_id            = aws_vpc.sysops_vpc.id
  cidr_block        = "10.99.12.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "AppLayer2private"
  }
}

# First Database Layer
resource "aws_subnet" "dbplayer1_private" {
  vpc_id            = aws_vpc.sysops_vpc.id
  cidr_block        = "10.99.21.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "DBLayer1private"
  }
}

# Second Database Layer
resource "aws_subnet" "dbplayer2_private" {
  vpc_id            = aws_vpc.sysops_vpc.id
  cidr_block        = "10.99.22.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "DBLayer2private"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.sysops_vpc.id

  tags = {
    Name = "IGW"
  }
}

resource "aws_nat_gateway" "ngw" {
  subnet_id         = aws_subnet.dmz2_public.id
  connectivity_type = "public"

  tags = {
    Name = "NGW"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.sysops_vpc.id

  tags = {
    Name = "PublicRT"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.sysops_vpc.id
  tags = {
    Name = "PrivateRT"
  }
}

resource "aws_route" "route_igw" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "route_ngw" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.ngw.id
}

resource "aws_route_table_association" "dmz1_association" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.dmz1_public.id
}

resource "aws_route_table_association" "dmz2_association" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.dmz2_public.id
}

resource "aws_route_table_association" "applayer1_association" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.applayer1_private.id
}

resource "aws_route_table_association" "applayer2_association" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.applayer2_private.id
}

resource "aws_route_table_association" "dblayer1_association" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.dbplayer1_private.id
}

resource "aws_route_table_association" "dblayer2_association" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.dbplayer2_private.id
}
