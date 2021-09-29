# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# These variables must be set when using this module.
# ---------------------------------------------------------------------------------------------------------------------

variable "folder" {
  type        = string
  description = "(Required) The resource name of the folder the policy is attached to. Its format is folders/{folder_id}."
}

variable "role" {
  type        = string
  description = "(Required) The role that should be applied. Only one google_project_iam_binding can be used per role. Note that custom roles must be of the format organizations/{{org_id}}/roles/{{role_id}}."
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL VARIABLES
# These variables have defaults, but may be overridden.
# ---------------------------------------------------------------------------------------------------------------------

variable "members" {
  type        = set(string)
  description = "(Optional) Identities that will be added/set to/for the role. Each entry can have one of the following values: 'allUsers', 'allAuthenticatedUsers', 'serviceAccount:{emailid}', 'group:{emailid}', 'domain:{domain}'."
  default     = []
}

variable "authoritative" {
  type        = bool
  description = "(Optional) Whether to exclusively set (authoritative mode) or add (non-authoritative/additive mode) members to the role."
  default     = false
}

variable "condition" {
  type        = any
  description = "(Optional) An IAM Condition for a given binding."
  default     = null
}

# ------------------------------------------------------------------------------
# MODULE CONFIGURATION PARAMETERS
# These variables are used to configure the module.
# ------------------------------------------------------------------------------

variable "module_enabled" {
  type        = bool
  description = "(Optional) Whether to create resources within the module or not. Default is 'true'."
  default     = true
}

variable "module_depends_on" {
  type        = any
  description = "(Optional) A list of external resources the module depends_on. Default is '[]'."
  default     = []
}
