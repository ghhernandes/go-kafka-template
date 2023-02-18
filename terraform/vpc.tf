locals {
  private_subnets = {
    "${var.region}a" = "192.168.1.0/24"
    "${var.region}b" = "192.168.2.0/24"
    "${var.region}c" = "192.168.3.0/24"
  }
}

resource "aws_vpc" "vpc" {
  cidr_block           = "192.168.0.0/22"
  enable_dns_support   = true
  enable_dns_hostnames = true
}


data "aws_availability_zones" "azs" {
  state = "available"
}

resource "aws_subnet" "private" {
  count             = length(local.private_subnets)
  availability_zone = element(keys(local.private_subnets), count.index)
  cidr_block        = element(values(local.private_subnets), count.index)
  vpc_id            = aws_vpc.vpc.id
}

resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.vpc.id
}

