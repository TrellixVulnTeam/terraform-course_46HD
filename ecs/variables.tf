variable "region" {
  default = "eu-west-1"
}

variable "ecs_cluster" {
  default = "my-cluster"
}

variable "key_pair_name" {
  default = "baston-key"
}

variable "max_instance_size" {
  default = 5
}

variable "min_instance_size" {
  default = 2
}

variable "desired_capacity" {
  default = 3
}

variable "ami" {
  type = map(string)
  default = {
    "eu-west-2" = "ami-00a1270ce1e007c27"
    "eu-west-1" = "ami-0ce71448843cb18a1"
    "eu-west-3" = "ami-03b4b78aae82b30f1"
  }
}

data "aws_availability_zones" "azs" {
}

variable "vpc_cidr" {
  default = "10.100.0.0/16"
}

variable "subnet_cidr" {
  type    = list(string)
  default = ["10.100.1.0/24", "10.100.2.0/24", "10.100.3.0/24"]
}

