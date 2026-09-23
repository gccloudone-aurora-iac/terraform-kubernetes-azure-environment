# Changelog

All notable changes to this module are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this
project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html). Releases are
cut automatically on merge to `main` from the release label applied to the pull request — see
[.github/workflows/trigger_release.yml](.github/workflows/trigger_release.yml).

## [v5.1.0] - 2026-09-22

No interface or state change: variables, outputs and module call names are untouched.

### Changed

- CI pins Terraform 1.12.2, up from 1.9.1.
- CI is now `terraform_checks.yml` (fmt, validate, examples, terraform-docs drift) and
  `trigger_release.yml` (release cut from the PR label).
- `.terraform-docs.yml` sets emoji section headings; generated tables are otherwise
  byte-identical to the default output. READMEs regenerated.
- README badges.
- Vendored the last two remote modules, `resource-names` and `resource-names-global`, from
  their `v2.0.0` tags across all 14 call sites. No `git::` module sources remain, so
  `terraform init` now contacts only the provider registry.
- Raised `required_version` to `>= 1.9.0, < 2.0.0` everywhere. The naming modules already
  required 1.9.0, so this documents the existing floor rather than raising it.

## [v5.0.0] - 2026-09-21

Consolidation release. The module now lives at
`gccloudone-aurora-iac/terraform-kubernetes-azure-environment`, so callers must update their
`source` URL. Terraform resource addresses are unchanged and no state migration is required.

### Changed

- Vendored the downstream infrastructure modules into [modules/](modules/) instead of
  referencing them as separate `git::https://` repositories. The two resource-names modules
  deliberately stay remote, pinned at `v2.0.0`.
- Velero storage accounts use `LRS` replication instead of `RAGZRS`.
- Uniform comment style across every `.tf` file, and a doc comment on every `resource`,
  `module` and `data` block.

### Added

- `terraform fmt`, `terraform validate` and a terraform-docs drift check in CI.
- A generated `README.md` for every vendored module.

### Fixed

- `examples/standard.tf` no longer fails validation; it has been rebuilt to show the default
  Aurora shape — supplied network, managed Cilium, VNet integration, no Route Server.
- Typos in comments and output descriptions, including `cluster_node_resource_group_id`,
  which described the cluster resource group rather than the node resource group.
- `.gitattributes` used the invalid line-ending value `eol=tf`; corrected to `eol=lf`.

## [v4.2.1] - 2026-07-08

### Fixed

- Deny network access to storage accounts by default when no rules match.

## [v4.2.0] - 2026-07-07

### Added

- Federated identity credential setup for the Thanos store and compactor in the downstream module.

## [v4.1.1] - 2026-06-25

### Added

- Support for `cluster_admins_owners`.

## [v4.1.0] - 2026-06-17

### Added

- User-assigned identity and storage account for Thanos.

## [v4.0.0] - 2026-05-22

### Changed

- **Breaking:** renamed `custom_ca` to `custom_ca_trust_certificates_base64` and changed its
  type from `string` to `list(string)`.

## [v3.1.0] - 2026-05-10

### Added

- API permissions on the Argo Workflows and Grafana application registrations.

## [v3.0.0] - 2026-05-09

### Fixed

- Service principal web redirect URIs.

## [v2.1.5] - 2026-04-14

### Changed

- Switched to the Cilium native CNI.

## [v2.1.3] - 2026-01-14

### Added

- `oidc_issuer_url` output, for upstream consumers.

## [v2.1.2] - 2026-01-09

### Changed

- Pass the OIDC issuer URL to the downstream module.

## [v2.1.1] - 2026-01-08

### Added

- Federated identity credential setup for cert-manager in the downstream module.

## [v2.1.0] - 2026-01-06

### Added

- Additional permissions for Velero operations in the platform-infrastructure module.

## [v2.0.9] - 2025-12-24

### Added

- Federated identity credential setup in the downstream platform-infrastructure module.

## [v2.0.8] - 2025-12-08

### Changed

- Workload identity is enabled by default in the downstream AKS module.

## [v2.0.7] - 2025-12-08

### Added

- Support for `os_sku` on node pools.

## [v2.0.6] - 2025-10-31

### Changed

- Default for `cluster_sku_tier` is now `Standard`.

## [v2.0.5] - 2025-10-31

### Added

- `cluster_diag_setting` variable, to configure the cluster's diagnostic setting.

## [v2.0.4] - 2025-10-20

### Added

- Option to disable virtual network integration.

## [v2.0.3] - 2025-10-20

### Changed

- Pinned the minimum version of the `azurerm` provider to 4.49.0.

## [v2.0.2] - 2025-10-20

### Added

- `cluster_support_plan` variable.

## [v2.0.1] - 2025-10-08

### Changed

- Uncommented the custom Velero role.

## [v1.0.0] - 2025-01-25

### Added

- Initial release.

[v5.0.0]: https://github.com/gccloudone-aurora-iac/terraform-kubernetes-azure-environment/releases/tag/v5.0.0
[v4.2.1]: https://github.com/gccloudone-aurora-iac/terraform-kubernetes-azure-environment/releases/tag/v4.2.1
[v4.2.0]: https://github.com/gccloudone-aurora-iac/terraform-kubernetes-azure-environment/releases/tag/v4.2.0
[v4.1.1]: https://github.com/gccloudone-aurora-iac/terraform-kubernetes-azure-environment/releases/tag/v4.1.1
[v4.1.0]: https://github.com/gccloudone-aurora-iac/terraform-kubernetes-azure-environment/releases/tag/v4.1.0
[v4.0.0]: https://github.com/gccloudone-aurora-iac/terraform-kubernetes-azure-environment/releases/tag/v4.0.0
[v3.1.0]: https://github.com/gccloudone-aurora-iac/terraform-kubernetes-azure-environment/releases/tag/v3.1.0
[v3.0.0]: https://github.com/gccloudone-aurora-iac/terraform-kubernetes-azure-environment/releases/tag/v3.0.0
[v2.1.5]: https://github.com/gccloudone-aurora-iac/terraform-kubernetes-azure-environment/releases/tag/v2.1.5
[v2.1.3]: https://github.com/gccloudone-aurora-iac/terraform-kubernetes-azure-environment/releases/tag/v2.1.3
[v2.1.2]: https://github.com/gccloudone-aurora-iac/terraform-kubernetes-azure-environment/releases/tag/v2.1.2
[v2.1.1]: https://github.com/gccloudone-aurora-iac/terraform-kubernetes-azure-environment/releases/tag/v2.1.1
[v2.1.0]: https://github.com/gccloudone-aurora-iac/terraform-kubernetes-azure-environment/releases/tag/v2.1.0
[v2.0.9]: https://github.com/gccloudone-aurora-iac/terraform-kubernetes-azure-environment/releases/tag/v2.0.9
[v2.0.8]: https://github.com/gccloudone-aurora-iac/terraform-kubernetes-azure-environment/releases/tag/v2.0.8
[v2.0.7]: https://github.com/gccloudone-aurora-iac/terraform-kubernetes-azure-environment/releases/tag/v2.0.7
[v2.0.6]: https://github.com/gccloudone-aurora-iac/terraform-kubernetes-azure-environment/releases/tag/v2.0.6
[v2.0.5]: https://github.com/gccloudone-aurora-iac/terraform-kubernetes-azure-environment/releases/tag/v2.0.5
[v2.0.4]: https://github.com/gccloudone-aurora-iac/terraform-kubernetes-azure-environment/releases/tag/v2.0.4
[v2.0.3]: https://github.com/gccloudone-aurora-iac/terraform-kubernetes-azure-environment/releases/tag/v2.0.3
[v2.0.2]: https://github.com/gccloudone-aurora-iac/terraform-kubernetes-azure-environment/releases/tag/v2.0.2
[v2.0.1]: https://github.com/gccloudone-aurora-iac/terraform-kubernetes-azure-environment/releases/tag/v2.0.1
[v1.0.0]: https://github.com/gccloudone-aurora-iac/terraform-kubernetes-azure-environment/releases/tag/v1.0.0
