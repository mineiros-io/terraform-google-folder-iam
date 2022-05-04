module "test" {
  source = "../.."

  module_enabled = false

  # add all required arguments

  folder = "folder/12345"

  # add all optional arguments that create additional/extended resources
}
