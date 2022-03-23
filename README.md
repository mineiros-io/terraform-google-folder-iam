[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>](https://mineiros.io/?ref=terraform-google-folder-iam)

[![Build Status](https://github.com/mineiros-io/terraform-google-folder-iam/workflows/Tests/badge.svg)](https://github.com/mineiros-io/terraform-google-folder-iam/actions)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/mineiros-io/terraform-google-folder-iam.svg?label=latest&sort=semver)](https://github.com/mineiros-io/terraform-google-folder-iam/releases)
[![Terraform Version](https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform)](https://github.com/hashicorp/terraform/releases)
[![Google Provider Version](https://img.shields.io/badge/google-4-1A73E8.svg?logo=terraform)](https://github.com/terraform-providers/terraform-provider-google/releases)
[![Join Slack](https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack)](https://mineiros.io/slack)

# terraform-google-folder-iam

A [Terraform](https://www.terraform.io) module to create a [Google Folder IAM](https://cloud.google.com/resource-manager/docs/access-control-folders) on [Google Cloud Services (GCP)](https://cloud.google.com/).

**_This module supports Terraform version 1
and is compatible with the Terraform Google Provider version 4._**

This module is part of our Infrastructure as Code (IaC) framework
that enables our users and customers to easily deploy and manage reusable,
secure, and production-grade cloud infrastructure.


- [Module Features](#module-features)
- [Getting Started](#getting-started)
- [Module Argument Reference](#module-argument-reference)
  - [Top-level Arguments](#top-level-arguments)
    - [Module Configuration](#module-configuration)
    - [Main Resource Configuration](#main-resource-configuration)
- [Module Outputs](#module-outputs)
- [External Documentation](#external-documentation)
  - [Google Documentation:](#google-documentation)
  - [Terraform Google Provider Documentation:](#terraform-google-provider-documentation)
- [Module Versioning](#module-versioning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

## Module Features

This module implements the following terraform resources:

- `google_folder_iam_binding`
- `google_folder_iam_member`
- `google_folder_iam_policy`

## Getting Started

Most basic usage just setting required arguments:

```hcl
module "terraform-google-folder-iam" {
  source = "github.com/mineiros-io/terraform-google-folder-iam.git?ref=v0.0.3"

  folder  = "folders/1234567"
  role    = "roles/editor"
  members = ["user:admin@example.com"]
}
```

## Module Argument Reference

See [variables.tf] and [examples/] for details and use-cases.

### Top-level Arguments

#### Module Configuration

- [**`module_enabled`**](#var-module_enabled): *(Optional `bool`)*<a name="var-module_enabled"></a>

  Specifies whether resources in the module will be created.

  Default is `true`.

- [**`module_depends_on`**](#var-module_depends_on): *(Optional `list(dependency)`)*<a name="var-module_depends_on"></a>

  A list of dependencies. Any object can be _assigned_ to this list to define a hidden external dependency.

  Example:

  ```hcl
  module_depends_on = [
    google_network.network
  ]
  ```

#### Main Resource Configuration

- [**`folder`**](#var-folder): *(**Required** `string`)*<a name="var-folder"></a>

  The resource name of the folder the policy is attached to. Its format is `folders/{folder_id}`.

- [**`role`**](#var-role): *(Optional `string`)*<a name="var-role"></a>

  The role that should be applied. Only one google_folder_iam_binding can be used per role. Note that custom roles must be of the format `organizations/{{org_id}}/roles/{{role_id}}`.

- [**`members`**](#var-members): *(Optional `set(string)`)*<a name="var-members"></a>

  Identities that will be granted the privilege in role. Each entry can have one of the following values:
  - `user:{emailid}`: An email address that represents a specific Google account. For example, alice@gmail.com or joe@example.com.
  - `serviceAccount:{emailid}`: An email address that represents a service account. For example, my-other-app@appspot.gserviceaccount.com.
  - `group:{emailid}`: An email address that represents a Google group. For example, admins@example.com.
  - `domain:{domain}`: A G Suite domain (primary, instead of alias) name that represents all the users of that domain. For example, google.com or example.com.

  Default is `[]`.

- [**`authoritative`**](#var-authoritative): *(Optional `bool`)*<a name="var-authoritative"></a>

  Whether to exclusively set `(authoritative mode)` or add `(non-authoritative/additive mode)` members to the role.

  Default is `true`.

- [**`policy_bindings`**](#var-policy_bindings): *(Optional `list(policy_binding)`)*<a name="var-policy_bindings"></a>

  A list of IAM policy bindings.

  Example:

  ```hcl
  policy_bindings = [{
    role    = "roles/viewer"
    members = ["user:member@example.com"]
  }]
  ```

  Each `policy_binding` object in the list accepts the following attributes:

  - [**`role`**](#attr-policy_bindings-role): *(**Required** `string`)*<a name="attr-policy_bindings-role"></a>

    The role that should be applied.

  - [**`members`**](#attr-policy_bindings-members): *(Optional `set(string)`)*<a name="attr-policy_bindings-members"></a>

    Identities that will be granted the privilege in `role`.

    Default is `var.members`.

  - [**`condition`**](#attr-policy_bindings-condition): *(Optional `object(condition)`)*<a name="attr-policy_bindings-condition"></a>

    An IAM Condition for a given binding.

    Example:

    ```hcl
    condition = {
      expression = "request.time < timestamp(\"2022-01-01T00:00:00Z\")"
      title      = "expires_after_2021_12_31"
    }
    ```

    The `condition` object accepts the following attributes:

    - [**`expression`**](#attr-policy_bindings-condition-expression): *(**Required** `string`)*<a name="attr-policy_bindings-condition-expression"></a>

      Textual representation of an expression in Common Expression Language syntax.

    - [**`title`**](#attr-policy_bindings-condition-title): *(**Required** `string`)*<a name="attr-policy_bindings-condition-title"></a>

      A title for the expression, i.e. a short string describing its purpose.

    - [**`description`**](#attr-policy_bindings-condition-description): *(Optional `string`)*<a name="attr-policy_bindings-condition-description"></a>

      An optional description of the expression. This is a longer text which describes the expression, e.g. when hovered over it in a UI.

- [**`audit_configs`**](#var-audit_configs): *(Optional `object(audit_config)`)*<a name="var-audit_configs"></a>

  List of audit logs settings to be enabled.

  Example:

  ```hcl
  # Enable full audit log coverage for all services
  audit_configs = [
      {
          service = "allServices"
          configs = [
              {
                  log_type = "DATA_READ"
              },
              {
                  log_type = "DATA_WRITE"
              },
              {
                  log_type = "ADMIN_READ"
              },
          ]
      }
  ]
  ```

  The `audit_config` object accepts the following attributes:

  - [**`service`**](#attr-audit_configs-service): *(**Required** `string`)*<a name="attr-audit_configs-service"></a>

    Service which will be enabled for audit logging.

    The special value `allServices` covers all services.
    Note that if there are `google_folder_iam_audit_config` resources covering both `allServices` and a specific service then the union of the two AuditConfigs is used for that service: the `log_types` specified in each `audit_log_config` are enabled, and the `exempted_members` in each `audit_log_config` are exempted.

  - [**`audit_log_configs`**](#attr-audit_configs-audit_log_configs): *(**Required** `list(audit_log_config)`)*<a name="attr-audit_configs-audit_log_configs"></a>

    A list of logging configurations for each type of permission.

    Example:

    ```hcl
    audit_log_configs = [{
      log_type = "ADMIN_READ"
      exempted_members = [
        "user:example@example.com"
      ]
    },
    {
      log_type = "DATA_WRITE"
    }]
    ```

    Each `audit_log_config` object in the list accepts the following attributes:

    - [**`log_type`**](#attr-audit_configs-audit_log_configs-log_type): *(**Required** `string`)*<a name="attr-audit_configs-audit_log_configs-log_type"></a>

      Permission type for which logging is to be configured.
      Must be one of `DATA_READ`, `DATA_WRITE`, or `ADMIN_READ`.

    - [**`exempted_members`**](#attr-audit_configs-audit_log_configs-exempted_members): *(Optional `set(string)`)*<a name="attr-audit_configs-audit_log_configs-exempted_members"></a>

      Identities that do not cause logging for this type of permission.
      The format is the same as that for `var.members`.

## Module Outputs

The following attributes are exported in the outputs of the module:

- [**`module_enabled`**](#output-module_enabled): *(`bool`)*<a name="output-module_enabled"></a>

  Whether this module is enabled.

- [**`iam`**](#output-iam): *(`object(iam)`)*<a name="output-iam"></a>

  All attributes of the created `iam_binding` or `iam_member` or
  `iam_policy` resource according to the mode.

## External Documentation

### Google Documentation:

- Folder IAM: https://cloud.google.com/resource-manager/docs/access-control-folders

### Terraform Google Provider Documentation:

- https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_folder_iam

## Module Versioning

This Module follows the principles of [Semantic Versioning (SemVer)].

Given a version number `MAJOR.MINOR.PATCH`, we increment the:

1. `MAJOR` version when we make incompatible changes,
2. `MINOR` version when we add functionality in a backwards compatible manner, and
3. `PATCH` version when we make backwards compatible bug fixes.

### Backwards compatibility in `0.0.z` and `0.y.z` version

- Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
- Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)

## About Mineiros

[Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
that solves development, automation and security challenges in cloud infrastructure.

Our vision is to massively reduce time and overhead for teams to manage and
deploy production-grade and secure cloud infrastructure.

We offer commercial support for all of our modules and encourage you to reach out
if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
[Community Slack channel][slack].

## Reporting Issues

We use GitHub [Issues] to track community reported issues and missing features.

## Contributing

Contributions are always encouraged and welcome! For the process of accepting changes, we use
[Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].

## Makefile Targets

This repository comes with a handy [Makefile].
Run `make help` to see details on each available target.

## License

[![license][badge-license]][apache20]

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE] for full details.

Copyright &copy; 2020-2022 [Mineiros GmbH][homepage]


<!-- References -->

[homepage]: https://mineiros.io/?ref=terraform-google-folder-iam
[hello@mineiros.io]: mailto:hello@mineiros.io
[badge-build]: https://github.com/mineiros-io/terraform-google-folder-iam/workflows/Tests/badge.svg
[badge-semver]: https://img.shields.io/github/v/tag/mineiros-io/terraform-google-folder-iam.svg?label=latest&sort=semver
[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[badge-terraform]: https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform
[badge-slack]: https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack
[build-status]: https://github.com/mineiros-io/terraform-google-folder-iam/actions
[releases-github]: https://github.com/mineiros-io/terraform-google-folder-iam/releases
[releases-terraform]: https://github.com/hashicorp/terraform/releases
[badge-tf-gcp]: https://img.shields.io/badge/google-3.x-1A73E8.svg?logo=terraform
[releases-google-provider]: https://github.com/terraform-providers/terraform-provider-google/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://mineiros.io/slack
[terraform]: https://www.terraform.io
[gcp]: https://cloud.google.com/
[semantic versioning (semver)]: https://semver.org/
[variables.tf]: https://github.com/mineiros-io/terraform-google-folder-iam/blob/variables.tf
[examples/]: https://github.com/mineiros-io/terraform-google-folder-iam/blob/main/examples
[issues]: https://github.com/mineiros-io/terraform-google-folder-iam/issues
[license]: https://github.com/mineiros-io/terraform-google-folder-iam/blob/main/LICENSE
[makefile]: https://github.com/mineiros-io/terraform-google-folder-iam/blob/main/Makefile
[pull requests]: https://github.com/mineiros-io/terraform-google-folder-iam/pulls
[contribution guidelines]: https://github.com/mineiros-io/terraform-google-folder-iam/blob/main/CONTRIBUTING.md
