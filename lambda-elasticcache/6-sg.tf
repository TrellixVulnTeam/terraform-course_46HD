#--------------------------------------------------------------------------------------------
resource "aws_security_group" "lambda-sg" {
  name        = "${local.default_name}-lambda-sg"
  description = "Allow https inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    # TLS (change to whatever ports you need)
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    #protocol    = "-1"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    # TLS (change to whatever ports you need)
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    #protocol    = "-1"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    #prefix_list_ids = ["pl-12c4e678"]
  }

  tags = {
    Name = "${local.default_name}-lambda-sg"
  }
}
#--------------------------------------------------------------------------------------------
resource "aws_security_group" "allow_mencache" {
  name        = "${local.default_name}-allow_tls"
  description = "Allow mencache inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    # TLS (change to whatever ports you need)
    from_port = 11211
    to_port   = 11211
    protocol  = "tcp"
    #protocol    = "-1"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    #cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.lambda-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #prefix_list_ids = ["pl-12c4e678"]
  }

  tags = {
    Name = "${local.default_name}-allow_tls"
  }
}
#--------------------------------------------------------------------------------------------
