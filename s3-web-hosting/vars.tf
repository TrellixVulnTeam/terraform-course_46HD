#-------------------------------------------------------------------
variable "aws_region" {
  default = "eu-west-1"
}
#-------------------------------------------------------------------
locals {
  default_name = join("-", list(terraform.workspace, "s3-static-web-app"))
}
#-------------------------------------------------------------------