#----------------------------------------------------------------------------
#create security groups to allow and deny traffic to the subnets
#on port 80 for http and 22 for ssh
#protocol value "-1 " is equivalent to all protocols 
#----------------------------------------------------------------------------
resource "aws_security_group" "project_vpc_sg-bastion" {
  name   = "project_vpc_sg-bastion"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = "project_vpc_sg-bastion"

  }
}

#------------------------------------------------------------------------------