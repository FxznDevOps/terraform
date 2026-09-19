resource "aws_vpc" "main" {

    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true
  tags = {
    Name = var.vpc_name   
  }
}


resource "aws_subnet" "public" {
  count = length(var.public_subnet)
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet[count.index]
  availability_zone = var.azs
  map_public_ip_on_launch = true
  
  tags = {
    Name = "${var.vpc_name}-public"   
  }

}


resource "aws_subnet" "private" {
  count = length(var.private_subnet)
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet[count.index]
  availability_zone = var.azs
  tags = {
    Name = "${var.vpc_name}-private"   
  }



}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.main.id

   tags = {
    Name = "${var.vpc_name}-igw"   
  }
 

}


resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id
  route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.ig.id
  }
  
    tags = {
    Name = "${var.vpc_name}-rtpoublic"   
  }


}



resource "aws_route_table_association" "rta" {
   
   count = length(var.public_subnet)
   subnet_id = aws_subnet.public[count.index].id
   route_table_id = aws_route_table.rt.id
  
}


resource "aws_eip" "nat" {
   tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id

  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "${var.vpc_name}-natgatway"   
  }


}

resource "aws_route_table" "rtnatgw" {
   vpc_id = aws_vpc.main.id
   route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
   }

}

resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.rtnatgw.id
  subnet_id = aws_subnet.private[0].id
  
}