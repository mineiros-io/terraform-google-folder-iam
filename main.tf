locals {
  create_binding = var.policy_bindings == null && var.role != null && var.authoritative
  create_member  = var.policy_bindings == null && var.role != null && var.authoritative == false
  create_policy  = var.policy_bindings != null
}

resource "google_folder_iam_binding" "folder" {
  count = var.module_enabled && local.create_binding ? 1 : 0

  depends_on = [var.module_depends_on]

  folder = var.folder
  role   = var.role

  members = var.members

  dynamic "condition" {
    for_each = var.condition != null ? ["condition"] : []

    content {
      title       = var.condition.title
      description = try(var.condition.description, null)
      expression  = var.condition.expression
    }
  }
}

resource "google_folder_iam_member" "folder" {
  for_each = var.module_enabled && local.create_member ? var.members : []

  folder = var.folder
  role   = var.role

  member = each.value

  dynamic "condition" {
    for_each = var.condition != null ? ["condition"] : []

    content {
      title       = var.condition.title
      description = try(var.condition.description, null)
      expression  = var.condition.expression
    }
  }
}

resource "google_folder_iam_policy" "policy" {
  count = var.module_enabled && local.create_policy ? 1 : 0

  folder      = var.folder
  policy_data = data.google_iam_policy.policy[0].policy_data

  depends_on = [var.module_depends_on]
}

data "google_iam_policy" "policy" {
  count = var.module_enabled && local.create_policy ? 1 : 0

  dynamic "binding" {
    for_each = var.policy_bindings

    content {
      role    = binding.value.role
      members = try(binding.value.members, var.members)

      dynamic "condition" {
        for_each = try([binding.value.condition], [])

        content {
          expression  = condition.value.expression
          title       = condition.value.title
          description = try(condition.value.description, null)
        }
      }
    }
  }
}

locals {
  audit_configs_map = { for c in var.audit_configs : c.service => c }
}

resource "google_folder_iam_audit_config" "folder" {
  for_each = var.module_enabled ? local.audit_configs_map : {}

  folder = var.folder

  service = each.value.service

  dynamic "audit_log_config" {
    for_each = each.value.audit_log_configs

    content {
      log_type         = audit_log_config.value.log_type
      exempted_members = try(audit_log_config.value.exempted_members, null)
    }
  }
}
