module "test" {
  source = "../.."

  module_enabled = false

  # add all required arguments

  folder = "folder/12345"

  # add all optional arguments that create additional/extended resources

  role = "roles/viewer"
  members = [
    "domain:example.com",
  ]
}

module "test-policy-audit" {
  source = "../.."

  module_enabled = false

  # add all required arguments

  folder = "folder/12345"

  # add all optional arguments that create additional/extended resources

  policy_bindings = [
    {
      role = "roles/viewer"
      members = [
        "domain:example.com",
      ]
    }
  ]

  audit_configs = [
    {
      service = "allServices"
      audit_log_configs = [
        {
          log_type = "DATA_WRITE"
          exempted_members = [
            "user:me@example.com"
          ]
        },
        {
          log_type = "ADMIN_READ"
        }
      ]
    }
  ]
}

module "test-policy" {
  source = "../.."

  module_enabled = false

  # add all required arguments

  folder = "folder/12345"

  # add all optional arguments that create additional/extended resources

  policy_bindings = [
    {
      role = "roles/viewer"
      members = [
        "domain:example.com",
      ]
    }
  ]
}

module "test-audit" {
  source = "../.."

  module_enabled = false

  # add all required arguments

  folder = "folder/12345"

  # add all optional arguments that create additional/extended resources

  audit_configs = [
    {
      service = "allServices"
      audit_log_configs = [
        {
          log_type = "DATA_WRITE"
          exempted_members = [
            "user:me@example.com"
          ]
        },
        {
          log_type = "ADMIN_READ"
        }
      ]
    }
  ]
}
