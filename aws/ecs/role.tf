data "aws_kms_key" "secrets_manager" {
  key_id = "alias/${var.kms_key_alias}"
}

resource "aws_iam_policy" "ecs_secrets" {
  name        = "${var.name}-ecs-secrets-policy"
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

resource "aws_iam_role" "ecs_task" {
  name = "${var.name}-ecs-task-execution-role"
  path = "/ecs/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs_secrets" {
  role       = aws_iam_role.ecs_task.id
  policy_arn = aws_iam_policy.ecs_secrets.arn
}
