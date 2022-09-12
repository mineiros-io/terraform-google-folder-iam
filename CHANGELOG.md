# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.2.0]

### Added

- Add support for `var.audit_configs` in `var.policy_bindings`
- Add support for `var.computed_members` variable

### Removed

- BREAKING CHANGES: Remove fallback to `var.members` in policy bindings

## [0.1.0]

### Fixed

- Fix error when `var.policy_bindings` is `null` thanks to @mscifo

## [0.0.4]

### Added

- Add support for `var.audit_configs`

## [0.0.3]

### Added

- Add validation to `var.members` and members in `var.policy_bindings`

## [0.0.2]

### Added

- Support for Terraform Google Provider version 4.x

## [0.0.1]

### Added

- Initial Implementation

[unreleased]: https://github.com/mineiros-io/terraform-google-folder-iam/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/mineiros-io/terraform-google-folder-iam/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/mineiros-io/terraform-google-folder-iam/compare/v0.0.4...v0.1.0
[0.0.4]: https://github.com/mineiros-io/terraform-google-folder-iam/compare/v0.0.3...v0.0.4
[0.0.3]: https://github.com/mineiros-io/terraform-google-folder-iam/compare/v0.0.2...v0.0.3
[0.0.2]: https://github.com/mineiros-io/terraform-google-folder-iam/compare/v0.0.1...v0.0.2
[0.0.1]: https://github.com/mineiros-io/terraform-google-folder-iam/releases/tag/v0.0.1
