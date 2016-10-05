provider "aws" {
  profile = "${var.aws_profile}"
  region  = "${var.region}"
}

module "vpc" {
  name            = "demo"
  source          = "github.com/terraform-community-modules/tf_aws_vpc"
  cidr            = "${var.vpc_cidr}"
  private_subnets = "${var.private_subnets}"
  public_subnets  = "${var.public_subnets}"
  azs             = "${var.azs}"
}

resource "aws_elb" "demo" {
  name = "aws-sthlm-20161006"

  subnets   = [ "${module.vpc.public_subnets}" ]
  instances = [ "${aws_instance.demo.*.id}" ]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  tags {
    Environment = "demo"
    Terraformed = "true"
  }
}

resource "aws_security_group" "elb_sg" {
  vpc_id  = "${module.vpc.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "${var.allowed_cidrs}"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "${var.allowed_cidrs}"
  }
}

resource "aws_instance" "demo" {
  count         = "${length(var.azs)}"
  ami           = "ami-ed82e39e"
  instance_type = "t2.micro"
  subnet_id     = "${element(module.vpc.private_subnets, count.index)}"

  tags {
    Environment = "demo"
    Terraformed = "true"
  }
}

resource "aws_security_group" "instance_sg" {
  vpc_id = "${module.vpc.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.allowed_cidrs}"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [ "${var.vpc_cidr}" ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "${var.allowed_cidrs}"
  }
}
