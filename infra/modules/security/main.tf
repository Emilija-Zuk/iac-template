resource "aws_security_group" "alb" {
  name        = "${var.project_name}-alb-sg"
  description = "allow web traffic from internet"
  vpc_id      = var.vpc_id
}

resource "aws_security_group" "ecs" {
  name        = "${var.project_name}-ecs-sg"
  description = "allow app traffic from alb only"
  vpc_id      = var.vpc_id
}

# alb inbound: http from internet
resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

# alb outbound: allow all
resource "aws_vpc_security_group_egress_rule" "alb_all" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# ecs inbound: app port only from alb sg
resource "aws_vpc_security_group_ingress_rule" "ecs_from_alb" {
  security_group_id            = aws_security_group.ecs.id
  referenced_security_group_id = aws_security_group.alb.id
  from_port                    = var.app_port
  to_port                      = var.app_port
  ip_protocol                  = "tcp"
}

# ecs outbound: allow all
resource "aws_vpc_security_group_egress_rule" "ecs_all" {
  security_group_id = aws_security_group.ecs.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}



resource "aws_security_group" "vpce" {
  name        = "${var.project_name}-vpce-sg"
  description = "allow https access to vpc interface endpoints"
  vpc_id      = var.vpc_id
}

# vpce inbound: https from inside vpc
resource "aws_vpc_security_group_ingress_rule" "vpce_https" {
  security_group_id = aws_security_group.vpce.id
  cidr_ipv4         = var.vpc_cidr
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

# vpce outbound: allow all
resource "aws_vpc_security_group_egress_rule" "vpce_all" {
  security_group_id = aws_security_group.vpce.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}


