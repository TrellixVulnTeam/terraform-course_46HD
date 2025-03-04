#declare variables
#-------------------------------------------------------------------
variable "AWS_REGION" {
  default = "eu-west-1"

}
#-------------------------------------------------------------------
data "aws_availability_zones" "azs" {}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
#---------------------------------------------------------------------
variable "subnet_cidr_public" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

}
#--------------------------------------------------------------------
variable "subnet_cidr_private" {
  type    = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

}

#----------------------------------------------------------------------
variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}
#-----------------------------------------------------------------------
variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-13be557e"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-04d5cc9b88f9d1d39"
  }
}
#-------------------------------------------------------------------
variable "instance_type" {
  default = "t2.micro"
}
#------------------------------------------------------------------------
#-------------------------------------------------------------------
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["137112412989"] # Amazon

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

#-------------------------------------------------------------------
#------------------------------------------------------------------------

