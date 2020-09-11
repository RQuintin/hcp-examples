data "aws_kms_key" "secrets_manager" {
  key_id = "alias/${var.kms_key_alias}"
}

resource "aws_iam_policy" "ecs_secrets" {
  name        = "${var.name}-ecs-secrets"
  path        = "/ecs/"
  description = "Permissions for secrets"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "secretsmanager:GetSecretValue",
        "kms:Decrypt"
      ],
      "Resource": [
        "${aws_secretsmanager_secret.hcp_consul.arn}",
        "${data.aws_kms_key.secrets_manager.arn}"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role" "ecs" {
  name = var.name
  path = "/ecs/"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ec2.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "ecs" {
  name = var.name
  role = aws_iam_role.ecs.name
}

resource "aws_iam_role_policy_attachment" "ecs_ec2_role" {
  role       = aws_iam_role.ecs.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ecs_ec2_cloudwatch_role" {
  role       = aws_iam_role.ecs.id
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_role_policy_attachment" "ecs_secrets" {
  role       = aws_iam_role.ecs.id
  policy_arn = aws_iam_policy.ecs_secrets.arn
}
