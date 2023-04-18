provider "aws" {
  region = "us-east-1"
}

variable "cidr-block" {
  description = "cidr block name tags for vpc and subnets"
  type = list(object({
    cidr-block=string
    name=string
  }))
}

variable "avail_zone" {}


resource "aws_vpc" "development-vpc" {
  cidr_block = var.cidr-block[0].cidr-block
  tags = {
    "Name" = var.cidr-block[0].name
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = var.cidr-block[1].cidr-block
  availability_zone = var.avail_zone
  tags = {
    "Name" = var.cidr-block[1].name
  }
}
