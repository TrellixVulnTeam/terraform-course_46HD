#-------------------------------------------------------------------
#declare variables
#-------------------------------------------------------------------
variable "AWS_REGION" {
  default = "eu-west-1"
}
#-------------------------------------------------------------------
variable "vpc" {
  type = map(any)
  default = {
    dev-vpc   = "10.1.0.0/16"
    qa-vpc    = "10.2.0.0/16"
    shrd-vpc  = "10.3.0.0/16"
    cadev-vpc = "10.4.0.0/16"
  }
}
#-------------------------------------------------------------------
data "aws_vpcs" "vpc-ids" {
  depends_on = [module.vpc1, module.vpc2]

  tags = {
    env = "TG"
  }
}
output "vpc-ids" {
  value = data.aws_vpcs.vpc-ids.ids
}
#-------------------------------------------------------------------
data "aws_availability_zones" "azs" {}

variable "dev-vpc_cidr" {
  default = "10.1.0.0/16"
}
variable "qa-vpc_cidr" {
  default = "10.2.0.0/16"
}
variable "shrd-vpc_cidr" {
  default = "10.3.0.0/16"
}
variable "cadev-vpc_cidr" {
  default = "10.4.0.0/16"
}
#---------------------------------------------------------------------
variable "dev_subnet_cidr_public" {
  type    = list(any)
  default = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
}
variable "qa_subnet_cidr_public" {
  type    = list(any)
  default = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
}
variable "shrd_subnet_cidr_public" {
  type    = list(any)
  default = ["10.3.1.0/24", "10.3.2.0/24", "10.3.3.0/24"]
}
variable "cadev_subnet_cidr_public" {
  type    = list(any)
  default = ["10.4.1.0/24", "10.4.2.0/24", "10.4.3.0/24"]
}
variable "public-subnets" {
  type = map(any)
  default = {
    dev-public-subnet   = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
    qa-public-subnet    = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
    shrd-public-subnet  = ["10.3.1.0/24", "10.3.2.0/24", "10.3.3.0/24"]
    cadev-public-subnet = ["10.4.1.0/24", "10.4.2.0/24", "10.4.3.0/24"]

  }
}
variable "private-subnets" {
  type = map(any)
  default = {
    dev-private-subnet   = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]
    qa-private-subnet    = ["10.2.101.0/24", "10.2.102.0/24", "10.2.103.0/24"]
    shrd-private-subnet  = ["10.3.101.0/24", "10.3.102.0/24", "10.3.103.0/24"]
    cadev-private-subnet = ["10.4.101.0/24", "10.4.102.0/24", "10.4.103.0/24"]
  }
}

#--------------------------------------------------------------------
variable "dev_subnet_cidr_private" {
  type    = list(any)
  default = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]
}
variable "qa_subnet_cidr_private" {
  type    = list(any)
  default = ["10.2.101.0/24", "10.2.102.0/24", "10.2.103.0/24"]
}
variable "shrd_subnet_cidr_private" {
  type    = list(any)
  default = ["10.3.101.0/24", "10.3.102.0/24", "10.3.103.0/24"]
}
variable "cadev_subnet_cidr_private" {
  type    = list(any)
  default = ["10.4.101.0/24", "10.4.102.0/24", "10.4.103.0/24"]
}
#-------------------------------------------------------------------
locals {
  default_name = join("-", list(terraform.workspace, "inecsoft"))
}
#-------------------------------------------------------------------

