module "test-sa" {
  source = "github.com/mineiros-io/terraform-google-service-account?ref=v0.0.10"

  project = local.project_id

  account_id = "service-account-id-${local.random_suffix}"
}

module "test" {
  source = "../.."

  # add all required arguments

  folder = "folder/12345"

  # add all optional arguments that create additional/extended resources

  role = "roles/viewer"
  members = [
    "domain:example.com",
    "computed:myserviceaccount",
  ]
  computed_members_map = {
    myserviceaccount = "serviceAccount:${module.test-sa.service_account.email}"
  }
}

module "test-policy-audit" {
  source = "../.."

  # add all required arguments

  folder = "folder/12345"

  # add all optional arguments that create additional/extended resources

  policy_bindings = [
    {
      role = "roles/viewer"
      members = [
        "computed:myserviceaccount",
      ]
      computed_members_map = {
        myserviceaccount = "serviceAccount:${module.test-sa.service_account.email}"
      }
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
