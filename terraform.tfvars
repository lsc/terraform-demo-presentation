aws_profile     = "default"
region          = "eu-west-1"
azs             = [ "eu-west-1a", "eu-west-1b", "eu-west-1c" ]
vpc_cidr        = "10.0.0.0/16"
private_subnets = [ "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]
public_subnets  = [ "10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24" ]
