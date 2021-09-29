resource "google_folder_iam_binding" "folder" {
  count = var.module_enabled && var.authoritative ? 1 : 0

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
  for_each = var.module_enabled && !var.authoritative ? var.members : []

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
