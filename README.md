# Terraform Module for GitHub OIDC AWS Role

Terraform module for creating GitHub OIDC role for AWS. This module will create the following resources:

- IAM Role
- IAM Policy
- IAM Policy Attachment

This module is designed to authenticate GitHub Actions with AWS using OIDC. The role created by this module can be assumed by GitHub Actions to perform actions on AWS.

## Pre-requisites

You need to have the following resources created before using this module:

```hcl
data "tls_certificate" "github" {
  url = "tls://token.actions.githubusercontent.com:443"
}

resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.github.certificates[0].sha1_fingerprint]
}
```

## Usage

```hcl
module "github-oidc-aws-role" {
  source            = "github.com/resizes/platform-terraform-module-github-oidc-aws-role?ref=main"
  name              = ${ROLE_NAME}
  org_name          = ${ORG_NAME}
  condition_test    = ${CONDITION_TEST}
  actions = [ ${ALLOWED_ACTIONS} ]
  assume_role_policy_condition_values = [
    "repo:${ORG_NAME}/${REPO}:ref:refs/heads/${BRANCH}",
    "repo:${ORG_NAME}/${REPO}:ref:refs/tags/${TAG}"
  ]
}
```

## References

- [Configuring OpenID Connect in Amazon Web Services](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)