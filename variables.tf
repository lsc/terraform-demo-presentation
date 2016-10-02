variable "vpc_cidr"        { }
variable "region"          { }
variable "aws_profile"     { }
variable "azs"             { type = "list" }
variable "private_subnets" { type = "list" }
variable "public_subnets"  { type = "list" }
