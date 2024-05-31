# VPC
resource "aws_vpc" "sysops_vpc" {
    cidr_block = "10.99.0.0/16"
    instance_tenancy = "default"
    
    tags = {
        Name = "SysOpsVPC"
    }
}