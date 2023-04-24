provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "myapp-vpc" {
    cidr_block = var.vpc-cidr-block
    tags = {
        Name = "${var.env-prefix}-vpc"
    }
}

module "myapp-subnet" {
    source = "./modules/subnet"
    subnet-cidr-block = var.subnet-cidr-block
    avail_zone = var.avail_zone
    env-prefix = var.env-prefix
    vpc_id = aws_vpc.myapp-vpc.id
    default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id
}

module "myapp-server" {
  source = "./modules/webserver"
  vpc_id = aws_vpc.myapp-vpc.id
  my-ip = var.my-ip
  env-prefix = var.env-prefix
  image-name = var.image-name
  public-key-location = var.public-key-location
  instance-type = var.instance-type
  subnet_id = module.myapp-subnet.subnet.id
  avail_zone = var.avail_zone
}
