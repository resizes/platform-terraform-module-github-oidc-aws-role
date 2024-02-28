variable "name" {
  type        = string
  description = "Name of the role."
}

variable "actions" {
  type        = list(string)
  default     = []
  description = "List of actions to allow."
}

variable "managed_policy_arns" {
  type        = list(string)
  default     = []
  description = "List of managed policy ARNs to attach to the role."
}

variable "org_name" {
  type        = string
  description = "GitHub organization name."
  default     = ""
}

variable "repo_path" {
  type        = string
  description = "GitHub repo path."
  default     = ""
}

variable "ref" {
  type        = string
  default     = "main"
  description = "GitHub ref name."
}

variable "condition_test" {
  type        = string
  default     = "StringEquals"
  description = "Condition test for the assume role policy. Can be StringEquals or StringLike. Add StringLike if you want to use wildcards."
}

variable "assume_role_policy_condition_values" {
  type        = list(string)
  description = "List of values that should be added as trusted to assume role"
  default     = []
}