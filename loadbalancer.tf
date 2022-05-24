resource "aws_elb" "web_elb" {
  name = var.lb_name
  security_groups = [
    aws_security_group.elb_layer_security_group.id
  ]
  subnets = [
    aws_subnet.public_subnet_az_1.id,
    aws_subnet.public_subnet_az_2.id
  ]

  cross_zone_load_balancing = true

  health_check {
    target              = "HTTP:${var.application_port}/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  listener {
    instance_port     = var.application_port
    instance_protocol = "http"
    lb_port           = var.lb_port
    lb_protocol       = "http"
  }

  tags = {
    Name = "web-elb"
  }
}

output "elb-dns-name" {
  value = aws_elb.web_elb.dns_name
}
