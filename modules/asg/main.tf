# Lunch template Config
resource "aws_launch_template" "lunch-template1" {
  name = "ubuntu-test-template1"
  image_id = var.image_id
  instance_type = var.instance_type
  key_name = var.key_name
  network_interfaces {
    security_groups = [var.web_security_groups_id]
  }

}

# auto scaling group config
resource "aws_autoscaling_group" "dhan-asg" {
  name = "dhan-asg"
  desired_capacity   = var.desired_capacity
  max_size           = var.max_size
  min_size           = var.min_size
  health_check_grace_period = 300
  vpc_zone_identifier = [var.public_subnet_id1, var.public_subnet_id2]

  launch_template {
    id      = aws_launch_template.lunch-template1.id
    version = "$Latest"
  }

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
}


# setup simple scaling policy
resource "aws_autoscaling_policy" "ec2-scaleUp" {
  name                   = "ec2-scaleUp"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.dhan-asg.name
}


# scaling up CloudWatch Alarm
resource "aws_cloudwatch_metric_alarm" "scaling-alarm" {
  alarm_name          = "terraform-test"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 20

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.dhan-asg.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.ec2-scaleUp.arn]
}

# setup scaling Down policy
resource "aws_autoscaling_policy" "ec2-scale-down" {
  name                   = "ec2-scaleUp"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.dhan-asg.name
}



# Scale Down Cloudwatch Alarm
resource "aws_cloudwatch_metric_alarm" "scale-down-alarm" {
  alarm_name          = "terraform-test"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 10

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.dhan-asg.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.ec2-scale-down.arn]
}