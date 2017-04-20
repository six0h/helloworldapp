provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags {
    Name = "main"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_subnet" "us-east-1a-public" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags {
    Name = "public-a"
  }
}

resource "aws_route_table" "us-east-1a-public" {
  vpc_id = "${aws_vpc.main.id}"
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.default.id}"
  }
  tags {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "us-east-1a-public" {
  subnet_id = "${aws_subnet.us-east-1a-public.id}"
  route_table_id = "${aws_route_table.us-east-1a-public.id}"
}
