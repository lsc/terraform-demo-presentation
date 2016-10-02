provider "aws" {
  profile = "${var.aws_profile}"
  region  = "${var.region}"
}

module "vpc" {
  name             = "demo"
  source           = "github.com/terraform-community-modules/tf_aws_vpc"
  cidr             = "${var.vpc_cidr}"
  private_networks = "${var.private_networks}"
  public_networks  = "${var.public_networks}"
  azs              = "${var.azs}"
}
