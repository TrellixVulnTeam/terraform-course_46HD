#---------------------------------------------------------------
resource "aws_key_pair" "suluq" {
  key_name   = "${local.default_name}-key"
  public_key = file("${var.PATH_TO_PUBLIC_KEY}")
}
#---------------------------------------------------------------
