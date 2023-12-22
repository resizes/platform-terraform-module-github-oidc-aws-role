# Terraform Module for GitHub OIDC AWS Role

Terraform module for creating GitHub OIDC role for AWS. This module will create the following resources:

- IAM Role
- IAM Policy
- IAM Policy Attachment

This module is designed to authenticate GitHub Actions with AWS using OIDC. The role created by this module can be assumed by GitHub Actions to perform actions on AWS.

## References

- [Configuring OpenID Connect in Amazon Web Services](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)