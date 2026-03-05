# Creation of Target Group for both Private EC2 Instances
resource "aws_lb_target_group" "private_ec2_tg" {
  name     = var.private_ec2_tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    protocol = "HTTP"
    path     = "/"
    port     = "traffic-port"
  }
}

# Attaching both EC2 instances to Target Group
resource "aws_lb_target_group_attachment" "private_ec2_a_attachment" {
    target_group_arn = aws_lb_target_group.private_ec2_tg.arn
    target_id = var.private_instance_ids[0]
    port = 80
}

resource "aws_lb_target_group_attachment" "private_ec2_b_attachment" {
    target_group_arn = aws_lb_target_group.private_ec2_tg.arn
    target_id = var.private_instance_ids[1]
    port = 80
}

# Creation of ALB
resource "aws_lb" "alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = var.load_balancer_type
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false
}

# Attach listener -> Both HTTP (80) + HTTPS (443)
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.acm_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private_ec2_tg.arn
  }
}