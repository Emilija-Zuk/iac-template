resource "aws_lb" "main" {
  name               = "${var.project_name}-alb"
  load_balancer_type = "application"
  internal           = false  # public

  subnets         = var.public_subnet_ids
  security_groups = [var.alb_sg_id]

  tags = {
    Name = "${var.project_name}-alb"
  }
}

resource "aws_lb_target_group" "blue" {
  name        = "${var.project_name}-tg-blue"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    protocol = "HTTP"
    path     = var.health_check_path
  }

  tags = {
    Name = "${var.project_name}-tg-blue"
  }
}

resource "aws_lb_target_group" "green" {
  name        = "${var.project_name}-tg-green"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    protocol = "HTTP"
    path     = var.health_check_path
  }

  tags = {
    Name = "${var.project_name}-tg-green"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.arn
  }
}
