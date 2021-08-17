#--------------------------------------------------------------------------------------
data "http" "workstation-external-ip" {
  url = "http://ipv4.icanhazip.com"
}
#--------------------------------------------------------------------------------------
locals {
  workstation-external-cidr = "${chomp(data.http.workstation-external-ip.body)}/32"
}
#----------------------------------------------------------------------------
provider "aws" {
  region = "eu-west-1"
}
#----------------------------------------------------------------------------------------
#In order to allow easy switching between versions you can define 
#a variable to allow the version number to be chosen dynamically
#----------------------------------------------------------------------------------------
locals {
  app_version = formatdate("YYYYMMDDHHmmss", timestamp())
}
#----------------------------------------------------------------------------------------
variable "FUNCTION_NAME" {
  default = "serverlesfunction"
}
#-------------------------------------------------------------------
locals {
  default_name = join("-", list(terraform.workspace, "lambda"))
}
#-------------------------------------------------------------------
resource "random_pet" "this" {
  length = 2
}
#-------------------------------------------------------------------

variable "app_versions" {
  default = "20200923161420"
}