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

resource "aws_alb" "demo" {
  subnets = "${mod.vpc.public_subnets}"

  tags {
    Environment = "demo"
    Terraformed = "true"
  }
}

resource "aws_instance" "demo" {
  count = "${length(${var.azs})}"
}
