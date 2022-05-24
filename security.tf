# LB Security Group

resource "aws_security_group" "elb_layer_security_group" {
  name        = var.lb_security_group
  description = "Allow HTTP traffic to instances through Elastic Load Balancer"
  vpc_id      = aws_vpc.primary_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow HTTP through ELB Security Group"
  }
}


# Web Application Layer Security Group

resource "aws_security_group" "webapp_layer_security_group" {
  name        = var.ec2_security_group
  description = "Allow HTTP inbound connections"
  vpc_id      = aws_vpc.primary_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #  ingress {
  #    from_port   = 22
  #    to_port     = 22
  #    protocol    = "tcp"
  #    cidr_blocks = ["0.0.0.0/0"]
  #  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow HTTP to EC2 Security Group"
  }
}
