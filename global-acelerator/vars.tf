#-------------------------------------------------------------------
variable "AWS_REGION" {
  default = "eu-west-1"
}
#-------------------------------------------------------------------
locals {
  default_name = join("-", list(terraform.workspace, "g-accelerator"))
}
#-------------------------------------------------------------------
