# VPC
resource "aws_vpc" "sysops_vpc" {
    cidr_block = "10.99.0.0/16"
    instance_tenancy = "default"
    
    tags = {
        Name = "SysOpsVPC"
    }
}

# Subnets

# First DMZ Layer
resource "aws_subnet" "dmz1_public" {
    vpc_id = aws_vpc.sysops_vpc.id
    cidr_block = "10.99.1.0/24"
    availability_zone = "us-east-1a"
    
    tags = {
        Name = "DMZ1public"
    }
}

# Second DMZ Layer
resource "aws_subnet" "dmz2_public" {
    vpc_id = aws_vpc.sysops_vpc.id
    cidr_block = "10.99.2.0/24"
    availability_zone = "us-east-1b"
    
    tags = {
        Name = "DMZ2public"
    }
}

# First App Layer
resource "aws_subnet" "applayer1_private" {
    vpc_id = aws_vpc.sysops_vpc.id
    cidr_block = "10.99.11.0/24"
    availability_zone = "us-east-1a"
    
    tags = {
        Name = "AppLayer1private"
    }
}

# Second App Layer
resource "aws_subnet" "applayer2_private" {
    vpc_id = aws_vpc.sysops_vpc.id
    cidr_block = "10.99.12.0/24"
    availability_zone = "us-east-1b"
    
    tags = {
        Name = "AppLayer2private"
    }
}

# First Database Layer
resource "aws_subnet" "dbplayer1_private" {
    vpc_id = aws_vpc.sysops_vpc.id
    cidr_block = "10.99.21.0/24"
    availability_zone = "us-east-1a"
    
    tags = {
        Name = "DBLayer1private"
    }
}

# Second Database Layer
resource "aws_subnet" "dbplayer2_private" {
    vpc_id = aws_vpc.sysops_vpc.id
    cidr_block = "10.99.22.0/24"
    availability_zone = "us-east-1b"
    
    tags = {
        Name = "DBLayer2private"
    }
}