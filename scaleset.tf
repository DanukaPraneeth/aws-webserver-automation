resource "aws_launch_configuration" "web" {
  name_prefix = var.web_server_name

  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = var.ssh_key


  security_groups             = [aws_security_group.webapp_layer_security_group.id]
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.web_instance_profile.id

  user_data = <<-EOF
			#!/bin/bash
			
			# install nginx
			sudo apt-get -y update
			sudo apt-get -y install nginx unzip
			
			# make sure nginx is started
			#sudo service nginx start
			curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
			unzip awscliv2.zip
			sudo ./aws/install
			sudo rm -rf /var/www/html/*
			aws s3 cp s3://bestseller-app-bucket/index.html /var/www/html/
			sudo service nginx start			
		EOF

  lifecycle {
    create_before_destroy = true
  }

}


resource "aws_autoscaling_group" "web" {
  name = "${aws_launch_configuration.web.name}-asg"

  min_size         = var.ec2_min_count
  desired_capacity = var.ec2_normal_count
  max_size         = var.ec2_max_count

  health_check_type = "ELB"
  load_balancers = [
    aws_elb.web_elb.id
  ]

  launch_configuration = aws_launch_configuration.web.name


  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]


  vpc_zone_identifier = [
    aws_subnet.private_subnet_az_1.id,
    aws_subnet.private_subnet_az_2.id
  ]

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_policy" "web_policy_up" {
  name                   = "web_policy_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.web.name
}


resource "aws_autoscaling_policy" "web_policy_down" {
  name                   = "web_policy_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.web.name
}



resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_down" {
  alarm_name          = "web_cpu_alarm_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "60"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web.name
  }

  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.web_policy_down.arn]
}

resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_up" {
  alarm_name          = "web_cpu_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web.name
  }

  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.web_policy_up.arn]
}
