data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
    condition {
      test     = var.condition_test
      variable = "token.actions.githubusercontent.com:sub"
      values   = length(var.assume_role_policy_condition_values) > 0 ? var.assume_role_policy_condition_values : ["repo:${var.org_name}/${var.repo_path}:ref:refs/heads/${var.ref}"]
    }
  }
}

resource "aws_iam_policy" "policy" {
  count = length(var.actions) > 0 ? 1 : 0
  name  = "${var.name}-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = var.actions
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "role" {
  name                = var.name
  assume_role_policy  = data.aws_iam_policy_document.assume_role_policy.json
  managed_policy_arns = length(var.actions) > 0 || length(var.managed_policy_arns) > 0 ? concat(var.managed_policy_arns, flatten(aws_iam_policy.policy[*].arn)) : []
}
