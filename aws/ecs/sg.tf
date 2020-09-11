resource "aws_security_group" "ecs" {
  name        = "ecs-security-group"
  description = "ECS security group"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs.id
}
