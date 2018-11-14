
resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc-cidr}"
  enable_classiclink = false
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"
  tags {
    Name = "${var.vpc-name}"
    Owner = "${var.owner}"
  }
}


resource "aws_subnet" "public-a" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "192.168.16.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true
  tags {
    Name = "${var.vpc-name}-public-a"
    Owner = "${var.owner}"
  }
}

resource "aws_subnet" "private-a" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "192.168.17.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = false
  tags {
    Name = "${var.vpc-name}-private-a"
    Owner = "${var.owner}"
  }
}

resource "aws_subnet" "public-b" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "192.168.18.0/24"
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = true
  tags {
    Name = "${var.vpc-name}-public-b"
    Owner = "${var.owner}"
  }
}

resource "aws_subnet" "private-b" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "192.168.19.0/24"
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = false
  tags {
    Name = "${var.vpc-name}-private-b"
    Owner = "${var.owner}"
  }
}

resource "aws_internet_gateway" "public-ig" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name = "${var.vpc-name} Gateway"
    Owner = "${var.owner}"
  }
}

resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw" {
  subnet_id = "${aws_subnet.public-b.id}"
  allocation_id = "${aws_eip.nat_eip.id}"
  depends_on = ["aws_internet_gateway.public-ig"]
}

resource "aws_route_table" "public-rtb" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.vpc-name}-public-rtb"
    Owner = "${var.owner}"
  }

}

resource "aws_route" "public-route-igw" {
  route_table_id = "${aws_route_table.public-rtb.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.public-ig.id}"
}

resource "aws_route_table" "private-rtb" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.vpc-name}-private-rtb"
    Owner = "${var.owner}"
  }
}

resource "aws_route" "private-route-nat" {
  route_table_id = "${aws_route_table.private-rtb.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${aws_nat_gateway.nat_gw.id}"
}

resource "aws_route_table_association" "public-a" {
  subnet_id = "${aws_subnet.public-a.id}"
  route_table_id = "${aws_route_table.public-rtb.id}"
}

resource "aws_route_table_association" "public-b" {
  subnet_id = "${aws_subnet.public-b.id}"
  route_table_id = "${aws_route_table.public-rtb.id}"
}

resource "aws_route_table_association" "private-a" {
  subnet_id = "${aws_subnet.private-a.id}"
  route_table_id = "${aws_route_table.private-rtb.id}"
}

resource "aws_route_table_association" "private-b" {
  subnet_id = "${aws_subnet.private-b.id}"
  route_table_id = "${aws_route_table.private-rtb.id}"
}

resource "aws_network_acl" "public" {
  vpc_id = "${aws_vpc.vpc.id}"
  subnet_ids = [
    "${aws_subnet.public-a.id}",
    "${aws_subnet.public-b.id}"]

  tags {
    Name = "${var.vpc-name}-public-acl"
    Owner = "${var.owner}"
  }
}

resource "aws_network_acl" "private" {
  vpc_id = "${aws_vpc.vpc.id}"
  subnet_ids = [
    "${aws_subnet.private-a.id}",
    "${aws_subnet.private-b.id}"]

  tags {
    Name = "${var.vpc-name}-private-acl"
    Owner = "${var.owner}"
  }
}

resource "aws_network_acl_rule" "public-acl-ingress-tcp" {
  network_acl_id = "${aws_network_acl.public.id}"
  rule_number = 100
  egress = false
  protocol = "tcp"
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
  from_port = 0
  to_port = 65535
}

resource "aws_network_acl_rule" "public-acl-egress-tcp" {
  network_acl_id = "${aws_network_acl.public.id}"
  rule_number = 110
  egress = true
  protocol = "tcp"
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
  from_port = 0
  to_port = 65535
}

resource "aws_network_acl_rule" "private-acl-ingress-vpc" {
  network_acl_id = "${aws_network_acl.private.id}"
  rule_number = 100
  egress = false
  protocol = "tcp"
  rule_action = "allow"
  cidr_block = "${var.vpc-cidr}"
  from_port = 0
  to_port = 65535
}

resource "aws_network_acl_rule" "private-acl-egress-tcp" {
  network_acl_id = "${aws_network_acl.private.id}"
  rule_number = 110
  egress = true
  protocol = "tcp"
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
  from_port = 0
  to_port = 65535
}