# create an elastic load balancer
#-------------------------------------------------------------------------------
resource "aws_elb" "my-elb" {
  name            = "my-elb"
  subnets         = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id, aws_subnet.main-3.id]
  security_groups = [aws_security_group.elb-securitygroup.id]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  #instances = ["${aws_instance.example-instance.id}"]
  # optional you can also attach an ELB to an autoscaling group.

  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "my-elb"
  }
}

#------------------------------------------------------------------------------

