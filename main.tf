provider "aws" {
	region = "${var.region}"
	access_key = "${var.access_key}"
	secret_key = "${var.secret_key}"
}


resource "aws_instance" "test" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  count = 1
  
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "private_network_access1" {
  name        = "private_network_access"
  description = "security group for private network access"
  vpc_id      = "${data.aws_vpc.default.id}"

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.16.0.0/16"]
    #cidr_blocks = ["0.0.0.0./0"]

  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
