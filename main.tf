resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = merge(
    var.common_tags,
    var.vpc_tags,
  
   {
    Name = local.name
    }
  )

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
   tags = merge(
    var.common_tags,
    var.ig_tags,

    {
      Name = local.name
    }
   )
}


resource "aws_subnet" "public" {
   count=length (var.public_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone = local.az_names[count.index]
tags = merge(
  var.common_tags,
  var.public_subnet_tags,

  {
    Name = "${local.name}-public-${local.az_names[count.index]}"
  }
)
}


resource "aws_subnet" "private" {
   count=length (var.private_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr[count.index]
  availability_zone = local.az_names[count.index]
tags = merge(
  var.common_tags,
  var.private_subnet_tags,

  {
    Name = "${local.name}-private-${local.az_names[count.index]}"
  }
)
}


resource "aws_subnet" "database" {
   count=length (var.database_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnet_cidr[count.index]
  availability_zone = local.az_names[count.index]
tags = merge(
  var.common_tags,
  var.database_subnet_tags,

  {
    Name = "${local.name}-database-${local.az_names[count.index]}"
  }
)
}

resource "aws_db_subnet_group" "default" {
  name       = "${local.name}"
  subnet_ids = aws_subnet.database[*].id

  tags = {
    Name = "${local.name}"
  }
}


resource "aws_eip" "eip" {
  domain           = "vpc"
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(
    var.common_tags,
    var.nat_gateway_tags,

     {
    Name = "${local.name}"
    }

  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.route_table_pubic_tags,

    {
      Name = "${local.name}-public"
    }
  )
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.route_table_private_tags,

    {
      Name = "${local.name}-private"
    }
  )
}



resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.route_table_databse_tags,

    {
      Name = "${local.name}-database"
    }
  )
}

resource "aws_route" "public" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    =  "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
  
}

resource "aws_route" "private" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.main.id
  
}

resource "aws_route" "database" {
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.main.id
  
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr)
  subnet_id  = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr)
  subnet_id  = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "database" {
  count = length(var.database_subnet_cidr)
  subnet_id = element(aws_subnet.database[*].id, count.index)
  route_table_id = aws_route_table.database.id
}