output "iam_role_name" {
  value       = aws_iam_role.role.name
  description = "Role ID created for OIDC authentication"
}
