resource "aws_vpc" "main" {
    cidr_block = var.vpc-cidr
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
      Name = "${var.cluster_name}"
    }
  
}

resource "aws_subnet" "public" {
    count = 2
    vpc_id = aws_vpc.main.id
    cidr_block = var.subnet-pub[count.index]
    availability_zone = var.subnet-zones[count.index]
    map_public_ip_on_launch = true
    tags = {
      Name = "${var.cluster_name}-public-${count.index == 0? "a": "b"}"
    }
    
}
resource "aws_subnet" "private" {
    count = 2
    vpc_id = aws_vpc.main.id
    cidr_block = var.subnet-pri[count.index]
    availability_zone = var.subnet-zones[count.index]
    map_public_ip_on_launch = false
    tags = {
      Name = "${var.cluster_name}-private-${count.index == 0? "a": "b"}"
    }
    
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    tags = {
      Name = "${var.cluster_name}-igw"
    }
  
}

resource "aws_eip" "eip" {
    domain = vpc
    tags = {
      Name = "${var.cluster_name}-nat-eip"
    }
      
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id = aws_subnet.public[0].id
  depends_on = [ aws_internet_gateway.igw ]
  tags = {
      Name = "${var.cluster_name}-nat"
    }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    route = {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
      tags = {
      Name = "${var.cluster_name}-public-rt"
    }
  
}
resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id
    route = {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat.id
    }
      tags = {
      Name = "${var.cluster_name}-private-rt"
    }
  
}

resource "aws_route_table_association" "private" {
    count = 2
    subnet_id = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private.id
  
}
resource "aws_route_table_association" "public" {
    count = 2
    subnet_id = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
  
}